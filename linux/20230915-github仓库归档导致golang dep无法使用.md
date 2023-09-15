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

```
git clone git@github.com:go-xorm/xorm.git
正克隆到 'xorm'...
ERROR: Repository `go-xorm/xorm' is disabled.
Please ask the owner to check their account.

fatal: 无法读取远程仓库。

请确认您有正确的访问权限并且仓库存在。
```

```
git clone https://github.com/go-xorm/xorm
正克隆到 'xorm'...
Username for 'https://github.com': liuyibao
Password for 'https://liuyibao@github.com': 
remote: Repository `go-xorm/xorm' is disabled.
remote: Please ask the owner to check their account.
fatal: 无法访问 'https://github.com/go-xorm/xorm/'：The requested URL returned error: 403
```


随后确定是第三方信赖仓库被归档原因。

手动从另一台机器 copy 源码到 $GOPATH/src/github.com/go-xorm, 执行 dep 仍然失败。

随后想到 dep 是不是使用了本地缓存

找到目录 $GOPATH/pkg/dep/sources/https---github.com-go--xorm-xorm/, 应该就是缺少这个目录， 从另一台机器 copy 过来。

再执行 dep ensure 就成功了。