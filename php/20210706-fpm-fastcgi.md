# 理解 php-fpm  fast-cgi 的工作机制
> php-fpm并不是每次请求就销毁

[转自 segmentfault](https://segmentfault.com/a/1190000018597945)

## 前言
现在的CGI基本没人使用，不安全以及性能极其低下，越来越多的使用web内置扩展、fastCGI。例如微软iis的ISAPI，apache的php模块，nginx的php-cgi。CGI、内置模块、fastcgi这三种性能最好的要属于fast_cgi速度最快，但是需要额外的进程。解析来看看CGI和FASTCGI有什么不同.

## CGI方式介绍：
cgi在2000年或更早的时候用得比较多，以前web服务器一般只处理静态的请求，如果碰到一个动态请求怎么办呢？web服务器会根据这次请求的内容，然后会fork一个新进程来运行外部c程序（或perl脚本...）， 这个进程会把处理完的数据返回给web服务器，最后web服务器把内容发送给用户，刚才fork的进程也随之退出。 如果下次用户还请求改动态脚本，那么web服务器又再次fork一个新进程，周而复始的进行。

## web内置模块介绍：
后来出现了一种更高级的方式是， web服务器可以内置perl解释器或php解释器。 也就是说这些解释器做成模块的方式，web服务器会在启动的时候就启动这些解释器。 当有新的动态请求进来时，web服务器就是自己解析这些perl或php脚本，省得重新fork一个进程，效率提高了。

## fastcgi方式介绍：
fastcgi的方式是，web服务器收到一个请求时，他不会重新fork一个进程（因为这个进程在web服务器启动时就开启了，而且不会退出），web服务器直接把内容传递给这个进程（进程间通信，但fastcgi使用了别的方式，tcp方式通信），这个进程收到请求后进行处理，把结果返回给web服务器，最后自己接着等待下一个请求的到来，而不是退出.

## 首先，CGI是干嘛的？CGI是为了保证web server传递过来的数据是标准格式的，方便CGI程序的编写者。

web server（比如说nginx）只是内容的分发者。比如，如果请求/index.html，那么web
server会去文件系统中找到这个文件，发送给浏览器，这里分发的是静态数据。好了，如果现在请求的是/index.php，根据配置文件，nginx知道这个不是静态文件，需要去找PHP解析器来处理，那么他会把这个请求简单处理后交给PHP解析器。Nginx会传哪些数据给PHP解析器呢？url要有吧，查询字符串也得有吧，POST数据也要有，HTTP
header不能少吧，好的，CGI就是规定要传哪些数据、以什么样的格式传递给后方处理这个请求的协议。仔细想想，你在PHP代码中使用的用户从哪里来的。
当web
server收到/index.php这个请求后，会启动对应的CGI程序，这里就是PHP的解析器。接下来PHP解析器会解析php.ini文件，初始化执行环境，然后处理请求，再以规定CGI规定的格式返回处理后的结果，退出进程。web
server再把结果返回给浏览器。

## 好了，CGI是个协议，跟进程什么的没关系。那fastcgi又是什么呢？Fastcgi是用来提高CGI程序性能的。

提高性能，那么CGI程序的性能问题在哪呢？"PHP解析器会解析php.ini文件，初始化执行环境"，就是这里了。标准的CGI对每个请求都会执行这些步骤（不闲累啊！启动进程很累的说！），所以处理每个时间的时间会比较长。这明显不合理嘛！那么Fastcgi是怎么做的呢？首先，Fastcgi会先启一个master，解析配置文件，初始化执行环境，然后再启动多个worker。当请求过来时，master会传递给一个worker，然后立即可以接受下一个请求。这样就避免了重复的劳动，效率自然是高。而且当worker不够用时，master可以根据配置预先启动几个worker等着；当然空闲worker太多时，也会停掉一些，这样就提高了性能，也节约了资源。这就是fastcgi的对进程的管理。

## 那PHP-FPM又是什么呢？是一个实现了Fastcgi的程序，被PHP官方收了。

大家都知道，PHP的解释器是php-cgi。php-cgi只是个CGI程序，他自己本身只能解析请求，返回结果，不会进程管理（皇上，臣妾真的做不到啊！）所以就出现了一些能够调度php-cgi进程的程序，比如说由lighthttpd分离出来的spawn-fcgi。好了PHP-FPM也是这么个东东，在长时间的发展后，逐渐得到了大家的认可（要知道，前几年大家可是抱怨PHP-FPM稳定性太差的），也越来越流行。

## 好了，最后来回来你的问题。 网上有的说，fastcgi是一个协议，php-fpm实现了这个协议

对

## 有的说，php-fpm是fastcgi进程的管理器，用来管理fastcgi进程的

对。php-fpm的管理对象是php-cgi。但不能说php-fpm是fastcgi进程的管理器，因为前面说了fastcgi是个协议，似乎没有这么个进程存在，就算存在php-fpm也管理不了他（至少目前是）。
有的说，php-fpm是php内核的一个补丁
以前是对的。因为最开始的时候php-fpm没有包含在PHP内核里面，要使用这个功能，需要找到与源码版本相同的php-fpm对内核打补丁，然后再编译。后来PHP内核集成了PHP-FPM之后就方便多了，使用--enalbe-fpm这个编译参数即可。

## 有的说，修改了php.ini配置文件后，没办法平滑重启，所以就诞生了php-fpm

是的，修改php.ini之后，php-cgi进程的确是没办法平滑重启的。php-fpm对此的处理机制是新的worker用新的配置，已经存在的worker处理完手上的活就可以歇着了，通过这种机制来平滑过度。

## 还有的说PHP-CGI是PHP自带的FastCGI管理器，那这样的话干吗又弄个php-fpm出

不对。php-cgi只是解释PHP脚本的程序而已。




![Visitor Count](https://profile-counter.glitch.me/brotherbigbao/count.svg)