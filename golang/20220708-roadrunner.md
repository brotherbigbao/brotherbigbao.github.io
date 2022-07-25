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

**Provider()** 目前的理解是手动定义提供依赖（Init方法一般指定需要的插件结构体，假如你要手动返回其它组件，需要用Provider方法），目前只在log插件中定义，返回zap logger组件。

## roadrunner 最小化配置

```
server:
  command: "php psr-worker.php"

http:
  address: 0.0.0.0:8088
  pool:
    num_workers: 4
```

## 核心插件 server, 实际的进程管理器

server是实际的php worker进程管理器，http插件接收到请求会交由server插件处理

## 核心插件 http

http 插件 Init 方法需要的依赖如下，其中 server.Server 就是进程管理器：

```
func (p *Plugin) Init(cfg cfgPlugin.Configurer, rrLogger *zap.Logger, srv server.Server) error
```

Serve() 方法是启动逻辑，调用了内部方法 serve()：

```
// Serve serves the svc.
func (p *Plugin) Serve() chan error {
	errCh := make(chan error, 2)
	// run whole process in the goroutine, needed for the PHP
	go func() {
		// protect http initialization
		p.mu.Lock()
		p.serve(errCh)
		p.mu.Unlock()
	}()

	return errCh
}
```

server() 方法关键代码，其中 p.server 就是依赖插件 server， 生成的 p.pool 用于最终的 p.handler生成

p.handler 是最终的 http 处理 handler，其实现了 ServeHTTP 方法，它又被 http.Plugin{} 的 ServeHTTP 方法调用，执行时被调用的是 http.Plugin{} 的 ServeHTTP 方法，要把 http.Plugin{} 看成是1个包装结构体 ：

```
var err error
p.pool, err = p.server.NewWorkerPool(context.Background(), p.cfg.Pool, map[string]string{RrMode: "http"}, p.log)
if err != nil {
    errCh <- err
    return
}

// just to be safe :)
if p.pool == nil {
    errCh <- errors.Str("pool should be initialized")
    return
}

p.handler, err = handler.NewHandler(
    p.cfg.HTTPConfig,
    p.cfg.Uploads,
    p.pool,
    p.log,
)
```

最终的 http 服务启动， 实际执行的是 ServeHTTP() 方法，可以详细看下原生 http 服务的 Handle定义，关键代码如下：

```
func (p *Plugin) ServeHTTP(w http.ResponseWriter, r *http.Request) {
    ...
    p.handler.ServeHTTP(w, r)
    ...
}
```

最终 handler 的 ServeHTTP 方法，在这个方法中构造了Payload并丢给进程管理执行：

```
// ServeHTTP transform original request to the PSR-7 passed then to the underlying application. Attempts to serve static files first if enabled.
func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
    pld := h.getPld()
    ...
    err = req.Payload(pld)
    ...
    wResp, err := h.pool.Exec(pld)
}
```

实际可以把 http 的 Plugin 结构当成一个包装器，实际 http 请求处理是在 handler 这个内部结构体中定义的。