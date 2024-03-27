# sunshine moonlight stream frp :no-index
> 串流

```
wget https://openpublic.oss-cn-shanghai.aliyuncs.com/gamestream/frp_0.56.0_linux_amd64.tar.gz
tar -zxvf frp_0.56.0_linux_amd64.tar.gz

服务端配置参考
https://github.com/fatedier/frp/blob/dev/conf/frps_full_example.toml

客户端配置参考
https://github.com/fatedier/frp/blob/dev/conf/frpc_full_example.toml

服务器端命令
frps -c frps.toml

windows客户端命令
frpc.exe -c frpc.ini 
```