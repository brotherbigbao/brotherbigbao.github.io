# dep ensure 失败， fatal: could not read Username for 'https://github.com'， ERROR: Repository `go-xorm/xorm' is disabled.
> github 仓库被归档， 导致golang dep 更新信赖失败

- dep ensure 报下面错误

```
Solving failure:
(1) failed to list versions for https://github.com/go-xorm/xorm: fatal: could not read Username for 'https://github.com': terminal prompts disabled
: exit status 128
(2) failed to list versions for ssh://git@github.com/go-xorm/xorm: ERROR: Repository `go-xorm/xorm' is disabled.
Please ask the owner to check their account.
```

本来以为是代理出了问题， 随后尝试手动git clone, 发现使用ssh方式提示 disabled, 尝试用https, 要求输入账号密码（实际需要使用Personal access token, 去 github 生成），仍然clone失败。

随后确定是第三方信赖仓库被归档原因。

手动从另一台机器 copy 源码到 $GOPATH/src/github.com/go-xorm, 执行 dep 仍然失败。

随后想到 dep 是不是使用了本地缓存

找到 $GOPATH/pkg/dep/sources/https---github.com-go--xorm-xorm/, 从另一台机器 copy 过来。

再执行 dep ensure 就成功了。