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

服务器端命令
nohup ./frps -c frps.toml &

windows客户端命令(用管理员账号执行cmd)
cd C:\Program Files\frp_0.56.0_windows_amd64
frpc.exe -c frpc.toml
```

## 关闭串流
```
ps -ef | grep frps
kill ?
```