# go modules 使用
> go modules 的常用命令

## 基础

1. go modules 默认依赖存放在$GOPATH/pkg/mod下


## 常用命令
```
#学会使用帮助
go help
go help mod

#初即化modules, example.com/hello是模块名称
go mod init example.com/hello

#会创建vendor目录将依赖copy进去
go mod vendor 

#编译时加上-mod=vendor会使用vendor，默认是不会使用vendor
go build -mod=vendor
```

## 相关链接

- [blog.golang.org/using-go-modules](https://blog.golang.org/using-go-modules)
- [再探go modules：使用与细节](https://www.cnblogs.com/apocelipes/p/10295096.html)

![Visitor Count](https://profile-counter.glitch.me/brotherbigbao/count.svg)