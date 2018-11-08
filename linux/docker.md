# 常用docker命令

```
# 开发机上想命令行上操作mysql或redis时可以用下面命令建立一个连接
docker exec -t -i container_name /bin/bash

# 帮助 记不起来了执行此命令查看大部分帮助
docker help

# 定期查看一下volume列表
docker volume ls

# 删除没有被任务container关联的volume, 注意docker-compose down之后容器会被销毁,此时执行此命令肯定会清除掉相关的volume,慎用
docker volume prune

# 查看某个容器的volume
docker inspect -f '{{ .Mounts }}' container_name
```

# 开发环境中docker容器内访问宿主机ip

https://docs.docker.com/docker-for-mac/networking/#use-cases-and-workarounds

```
For me the followings works on Docker for Mac:

xdebug.remote_autostart=0
xdebug.remote_enable=1
xdebug.default_enable=0
xdebug.remote_host=docker.for.mac.host.internal
xdebug.remote_port=9000
xdebug.remote_connect_back=0
xdebug.profiler_enable=0
xdebug.remote_log="/tmp/xdebug.log"
The docker.for.mac.host.internal host prevent scratching the head regarding IP alias or no network at all on host side. The source comes from the docker documentation https://docs.docker.com/docker-for-mac/networking/#use-cases-and-workarounds

No needs for extra configuration or environment variable in docker compose.
```

# osx系统中/var/lib/docker的实际位置

OSX系统的Docker实际是在一个虚拟机中
```
~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/Docker.qcow2
```

> https://stackoverflow.com/questions/38532483/where-is-var-lib-docker-on-mac-os-x


# docker中php相关帮助文档

[https://docs.docker.com/samples/library/php/](https://docs.docker.com/samples/library/php/)