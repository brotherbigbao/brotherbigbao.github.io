# PDO 预处理
> PDO ATTR_EMULATE_PREPARES 设置有什么用

## 我们都知道在Yii2的数据库配置中有一项叫做emulatePrepare

```
return [
	'class' => 'yii\db\Connection',
	'dsn' => 'mysql:host=localhost;dbname=yii-study.local.com',
	'username' => 'root',
	'password' => '',
	'charset' => 'utf8',
	'emulatePrepare'=>true
];
```

很多同学都知道这其实是一个PDO的属性，代表PDO::ATTR_EMULATE_PREPARES - 是否启用预处理，我们yii默认为null，表示默认PDO对该属性当前的设置，不做处理。当然你可以像上面配置文件一样人为的指定该值为true / false。

关于yii对 emulatePrepare 的处理我们可以在Connection类中轻松发现，它仅仅是yii是否开启PDO::ATTR_EMULATE_PREPARES 的一个开关而已。

因此我们研究的核心问题就回到 PDO的ATTR_EMULATE_PREPARES到底能起到什么作用的问题上来了？

## 我们先列目录

为何预处理能防止SQL注入

ATTR_EMULATE_PREPARES

推荐的策略

Begin...

## 为何预处理能防止SQL注入
我们都知道，SQL注入是通过触发脚本在构造SQL语句时包含恶意的字符串，而数据库预处理机制就是为了解决此危险而诞生的，数据库的预处理一般分为两步

拿mysql为例，第一步是prepare阶段，发送带有占位符的sql语句到mysql服务器，然后就可以多次发送占位符参数给mysql服务器进行执行，参数将会被当作普通字符处理。这就相当于我们为一个函数传参数一样，参数不会再去影响整个sql的构成。因此直接屏蔽了所有的SQL注入问题。

但是，并不是所有的数据库都支持预处理，否则也不需要ATTR_EMULATE_PREPARES 出马了~~

ATTR_EMULATE_PREPARES

ATTR_EMULATE_PREPARES代表是否启用PDO自身的模拟预处理，因为总有些数据库是很另类的不支持预处理的，但是我们为了安全，PDO就决定老哥自己来模拟预处理的机制。

当我们将ATTR_EMULATE_PREPARES 设置为 true时，PDO开始模拟预处理机制，要记住，这些是PDO自己的事情，和数据库没有半毛钱关系，换句话说，数据库收到的仍然是一个字符串拼凑好的SQL语句。

在PHP5.3.8之前，PDO预处理也存在着因字符类型不同而被注入的问题，因此很多人是不推荐的，现在已经没事了。

## 那么你肯定要问了，既然都很安全，到底是PDO的好还是数据库自己的好那？

我们还是以MySQL为例

PDO的预处理一次发送完整的sql给mysql执行，不需要MySQL做额外处理（如保存会话状态等），因此性能比较好一些，而使用MySQL预处理则需要多次发送，MySQL服务器需要保存会话状态，性能上会有一些损耗。PDO > MySQL

MYSQL预处理在prepare阶段就能检测出sql语句的错误，而使用PDO的预处理方式制定在exec阶段才能发现（因为模拟方式拼接好sql在exec阶段才会发送到MySQL服务器）。PDO < MySQL

且如果你在同一次数据库连接会话中执行同样的语句许多次，它将只被解析一次，这可以提升一点执行速度。PDO < MySQL

基于上面理由，我们推荐你优先使用数据库自身的预处理，大家也都是这样干的~

因此一个更牛逼的配置出现了，见下文。

## 推荐的策略
为何是牛逼的策略那，按照你的理解，如果我们优先使用数据库预处理是不是要 ATTR_EMULATE_PREPARES = false操作。

但是此false非彼false。

当你设置了ATTR_EMULATE_PREPARES = false时，的确我们会采用数据库的预处理，但是PHP知道安全才是第一位的，因此即便你设置了false，当数据库自己的预处理突然抽风不好用了的时候，PDO并没有放弃，而是立刻启动自身的模拟预处理，保障数据的安全性。

'emulatePrepare'=>false
对了，就是false，false，false。

不知道你是否听懂~~~

[转自此处](https://www.yiichina.com/topic/6879)