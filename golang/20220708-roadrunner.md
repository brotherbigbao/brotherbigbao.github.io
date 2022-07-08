# roadrunner 用golang写的php进程管理器
> roadrunner 用golang写的php进程管理器

## 代码解析

- 1.命令行用到的依赖 spf13/cobra
- 2.配置相关用到的 spf13/viper
- 3.roadrunner核心插件 endure，实现类似依赖注入功能，插件系统的根基 https://github.com/roadrunner-server/endure

## endure 依赖注入容器，插件系统的根基

- **Init()** error - is mandatory to implement. For your structure (which you pass to Endure), you should have this method as the method of the struct(go func (p *Plugin) Init() error {}). It can accept as a parameter any passed to the Endure structure (see samples) or interface (with limitations).
- **Service** - is optional to implement. It has 2 methods - Serve which should run the plugin and return initialized golang channel with errors, and Stop to shut down the plugin. The Stop and Serve should not block the execution.
- **Provider** - is optional to implement. It is used to provide some dependency if you need to extend your struct without deep modification.
- **Collector** - is optional to implement. It is used to mark a structure (vertex) as some struct dependency. It can accept interfaces which implement a caller.
- **Named** - is mandatory to implement. This is a special kind of interface which provides the name of the struct ( plugin, vertex) to the caller. Is useful in logger (for example) to know user-friendly plugin name.


**Init()** 每个插件必须实现，插件注册的时候就会调用，Init()方法的参数指定了需要的依赖。

**Collector()** 目的也是手动指定依赖，在http插件中有这个方法，用于注入http拦截器。

**Provider()** 目前的理解是手写定义提供依赖（Init方法一般指定需要的插件结构体，假如你要手动返回其它组件，需要用Provider方法），目前只在log插件中定义，返回zap logger组件。