# Mac或Linux git ssh 代理办法
> git ssh 方式代理办法

转自: [GitHub 加速终极教程](https://hellodk.cn/post/975)           [v2ex: GitHub 加速终极教程](https://www.v2ex.com/t/843383)

本文意图解决使用 GitHub 访问(https) 或者 git clone（https or ssh）慢的问题。在此分享我的方法，我所了解的 GitHub 加速最佳方案。

> 前提是，你的木弟子应该还行，木弟子越好，GitHub 体验越好

很多文章没有讲全面，只讲了 http proxy，而没有讲 ssh proxy。事实上大部分程序员使用 GitHub 都会使用 SSH keys（普通用户可能就不会了），在本机生成 rsa 公私钥(其他的类型还有 dsa | ecdsa | ecdsa-sk | ed25519 | ed25519-sk)，然后把公钥内容拷贝、设置进 GitHub。

所以程序员 clone 一个仓库一般是 ssh clone 而不是 https clone

```
$ git clone git@github.com:xxx/yyy.git
```

如果你不配置 ssh 代理或者没有透明代理之类的网络环境（其实还有一些代理工具，不过更加小众），直接硬拖到本地大概率是很慢的。如果使用 http 代理，如果木弟子质量好，其实也还行

```
$ git clone https://github.com/xxx/yyy.git
```

但这样不如 ssh clone 稳定。下面我们来设置 http proxy 和 ssh proxy。

# 设置 Http Proxy

```
$ git config --global http.proxy socks5://127.0.0.1:7890
```

因为 git 底层使用 libcurl 发送 http 请求，而 libcurl 的代理使用 socks5:// 时会在本地解析 DNS，实际使用中我们希望 DNS 也在远程（也就是可以访问 google 的代理节点）解析，所以使用 socks5h ，即

```
$ git config --global http.proxy socks5h://127.0.0.1:7890
```

h 代表 host，包括了域名解析，即域名解析也强制走这个 proxy。另外不需要配置 https.proxy，这些 git server 都会配置 http redirect to https。

推荐使用 socks5 代理，因为 socks5 包含 http(s)。而且 socks5 代理工作在 osi 七层模型中的会话层（第五层），https/http 代理工作在 osi 七层模型的应用层（第七层）, socks 代理更加底层。所以就没必要配置 git config --global http.proxy http://127.0.0.1:7890 了。

RFC1928 中有下面这段话

```
The protocol described here is designed to provide a framework for
client-server applications in both the TCP and UDP domains to
conveniently and securely use the services of a network firewall.
The protocol is conceptually a "shim-layer" between the application
layer and the transport layer, and as such does not provide network-
layer gateway services, such as forwarding of ICMP messages.
```

这段话是说 “该协议在概念上是应用层和传输层之间的“填充层”，因此不提供网络层网关服务，例如转发 ICMP 消息。” 看上去是没有明确表示是表示层（第 6 层）和传输层（第 4 层）之间的第五层，但是这个“填充层” SOCKS 条目的 wikipedia 中有补充是会话层（第 5 层）。见 https://en.wikipedia.org/wiki/SOCKS


> SOCKS performs at Layer 5 of the OSI model (the session layer, an intermediate layer between the presentation layer and the transport layer). A SOCKS server accepts incoming client connection on TCP port 1080, as defined in RFC 1928.

好了，说回来。但这样配置的话会使本机所有的 git 服务都走了代理，假如你在良心云上（国内主机）部署了自己的 gitea，服务地址 https://gitea.example.com，那么可以只配置 GitHub 的 http proxy，即

```
$ git config --global http.https://github.com.proxy socks5://127.0.0.1:7890
```

这样做实际上是修改了 ~/.gitconfig 文件，添加了如下内容

```
[http "https://github.com"]
proxy = socks5://127.0.0.1:7890
```

# 设置 SSH Proxy
## Linux & macOS

配置文件在用户家目录下的 .ssh/config 其中 nc 程序位于 /usr/bin/nc

```
$ cat ~/.ssh/config

Host github.com
Hostname ssh.github.com
IdentityFile /xxx/.ssh/github_id_rsa
User git
Port 443
ProxyCommand nc -v -x 127.0.0.1:7890 %h %p
```

nc 就是 netcat，引用一段描述

> netcat is a simple unix utility which reads and writes data across network connections, using TCP or UDP protocol. It is designed to be a reliable "back-end" tool that can be used directly or easily driven by other programs and scripts. At the same time, it is a feature-rich network debugging and exploration tool, since it can create almost any kind of connection you would need and has several interesting built-in capabilities. Netcat, or "nc" as the actual program is named, should have been supplied long ago as another one of those cryptic but standard Unix tools.

译文: netcat 是一个简单的 unix 实用程序，它使用 TCP 或 UDP 协议跨网络连接读取和写入数据。 它被设计成一个可靠的“后端”工具，可以直接使用或由其他程序和脚本轻松驱动。 同时，它还是一个功能丰富的网络调试和探索工具，因为它几乎可以创建您需要的任何类型的连接，并且具有几个有趣的内置功能。 Netcat，或实际程序命名的“nc”，早就应该作为另一种神秘但标准的 Unix 工具提供。

## Windows
Win 下与之对应的 netcat 程序是 connect.exe，程序位于 Git 安装路径 C:\Program Files\Git\mingw64\bin，win 下推荐使用 Git Bash，路径也是 Linux style

因为 connect 程序内置在 Git 中，只要是正常安装 Git 的电脑环境都有这个程序，在 Git Bash 终端输入 connect 即可知晓程序路径在 C:\Program Files\Git\mingw64\bin\connect.exe

```
$ connect
connect --- simple relaying command via proxy.
Version 1.105
usage: C:\Program Files\Git\mingw64\bin\connect.exe [-dnhst45] [-p local-port]
[-H proxy-server[:port]] [-S [user@]socks-server[:port]]
[-T proxy-server[:port]]
[-c telnet-proxy-command]
host port
```

Win 下的配置写法如下

```
$ cat ~/.ssh/config

Host github.com
Hostname ssh.github.com
IdentityFile /c/users/xxx/.ssh/github_id_rsa
User git
Port 443
ProxyCommand connect -S 127.0.0.1:7890 %h %p
```

# 补充信息
## Q&A 1

为什么 hostname 是 ssh.github.com，为什么要用 443 端口，ssh 默认不是 22 端口么？

因为有些木弟子对于 22 端口做了限制，要么禁止了，要么有些抽风，这时经常会遇到如下错误

> kex_exchange_identification: Connection closed by remote host

所以如果 22 端口不畅就使用 443，安全稳定可靠。ps: 22 端口时 hostname 请填 github.com。这部分请扩展阅读 [此文](https://docs.github.com/cn/authentication/troubleshooting-ssh/using-ssh-over-the-https-port) 。

## Q&A 2

如果代理设置了用户名和密码基础认证呢？比如 clash 的 config.yaml 中就可以添加如下配置以增加 http 基础认证
```
authentication:
  - "USERNAME:PASSWORD"
```

那么写成 ProxyCommand nc -v -x USERNAME@127.0.0.1:7890 %h %p 执行命令的时候终端会让输入密码。

经测试，写成 ProxyCommand nc -v -x USERNAME:PASSWORD@127.0.0.1:7890 %h %p 不行，会把 USERNAME:PASSWORD 识别成用户名。不用输入密码的方案我暂时没找到。

至于网页访问 GitHub，借助木弟子访问已然是日常，要么浏览器扩展 SwitchyOmega，要么系统代理，要么直接使用 Clash 的分流策略等等。我的习惯还是使用 Switchy Omega。

这样配置之后 git clone https://github.com/xxx/yyy.git 或者 git clone git@github.com:xxx/yyy.git 以及 git pull、git push 等等操作都很快了，除非科学的工具或节点不行。

难免有误，欢迎大家补充和斧正。

