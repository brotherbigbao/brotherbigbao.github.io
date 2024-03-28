# sunshine moonlight stream frp :no-index
> 串流

## 开启串流
```
wget https://openpublic.oss-cn-shanghai.aliyuncs.com/gamestream/frp_0.56.0_linux_amd64.tar.gz
tar -zxvf frp_0.56.0_linux_amd64.tar.gz

服务端配置参考
https://github.com/fatedier/frp/blob/dev/conf/frps_full_example.toml

客户端配置参考
https://github.com/fatedier/frp/blob/dev/conf/frpc_full_example.toml

```

## 服务器开启串流

```
nohup ./frps -c frps.toml &

# 可以配置到alias方便操作
vim .profile
alias frpStart='cd ~/frp_0.56.0_linux_amd64 && nohup ./frps -c frps.toml &'
```

## 服务器关闭串流
```
ps -ef | grep frp | grep -v grep
kill ?

# 只返回进程号
ps -ef | grep frp | grep -v grep | awk '{print $2}'

# 检查状态
alias frpStatus='ps -ef | grep frp | grep -v grep'

# 直接kill
alias frpKill="kill $(ps -ef | grep frp | grep -v grep | awk '{print $2}')"
```

## 服务器最终命令配置

```shell
alias frpStart='cd ~/frp_0.56.0_linux_amd64 && nohup ./frps -c frps.toml &'
alias frpStatus='ps -ef | grep frp | grep -v grep'
alias frpLog='cd ~/frp_0.56.0_linux_amd64 && tail -f nohup.out'
alias frpKill="kill $(ps -ef | grep frp | grep -v grep | awk '{print $2}')"
```

## windows客户端开启串流

```
# windows客户端命令(用管理员账号执行cmd)
cd C:\Program Files\frp_0.56.0_windows_amd64
frpc.exe -c frpc.toml
```