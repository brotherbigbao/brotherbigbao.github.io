# yii2-queue 消费太慢
> 原因是yii2-queue 取到一条消息后，会fork子进程

## 原因

yii2-queue 取到一条消息后，会fork一个子进程，让子进程处理消息，fork成本有点高，改成主进程直接处理会快很多，有空研究下laravel子进程处理逻辑

简单看了下 laravel 和 yii 使用的都是 Symfony\Component\Process

## listen时禁用子进程就可以，supervisor配置示例

supervisor可以指定执行command的user，只是我们这个项目比较特殊，需要用到环境变量，所以使用su - sre，一般情况不要这样用，是个不好的习惯

```
[program:queue-test]
process_name=%(program_name)s_%(process_num)02d
command=su - sre -s /bin/bash -c  "/export/apps/zaphkiel/yii queue-entrance/listen 5 --isolate=0 --verbose=1 --color=0"
autostart=true
autorestart=true
startretries=20
numprocs=4
redirect_stderr=true
stdout_logfile=/data/logs/queue/queue_queue_test.log
stdout_logfile_maxbytes=1GB
stdout_logfile_backups=50
```

## 配置 --isolate 碰到的问题

配置 --isolate 就不会再fork子进程，一直在父进程中处理，但是假如数据库断开这种问题发生，目前yii无法重连，需要优化一下，详见这篇 [yii-mysql-connect](20210420-yii-mysql-connect.md)

也可以写一个脚本监控运行状态，看下面

## 监控 yii2-queue 队列 阀值仅供参考

执行 
```
/app/yii queue-test/info
```

返回
```
Jobs
- waiting: 0
- delayed: 0
- reserved: 56
- done: 1
```

判断
```
waiting > 3000，报堵塞
reserved > 100，报失败队列过多，重启进程  supervisorctl restart queue-test:*
```
