# sunshine moonlight stream frp :no-index
> 串流
> 内网穿透主要参考：https://www.ruterfu.com/2020/01/11/20200110-try-to-use-frp-build-mobile-game-device/， 作者这篇文章其实有点老了，实际以官方文档为准

## frp 内网穿透
```
wget https://openpublic.oss-cn-shanghai.aliyuncs.com/gamestream/frp_0.56.0_linux_amd64.tar.gz
tar -zxvf frp_0.56.0_linux_amd64.tar.gz

服务端配置参考
https://github.com/fatedier/frp/blob/dev/conf/frps_full_example.toml

客户端配置参考
https://github.com/fatedier/frp/blob/dev/conf/frpc_full_example.toml

穿透相关配置参照博客（文章内容有点老，可以做参考）：
https://www.ruterfu.com/2020/01/11/20200110-try-to-use-frp-build-mobile-game-device/

实际需要穿透哪些端口，看了Sunshine的web管理后台，上面有显示所有用到的端口，注意区分tcp和udp，别填错了
```

## frp 服务器开启穿透

```
nohup ./frps -c frps.toml &

# 可以配置到alias方便操作
vim .profile
alias frpStart='cd ~/frp_0.56.0_linux_amd64 && nohup ./frps -c frps.toml &'
```

## frp 服务器关闭穿透
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

## frp 服务器最终命令配置

```shell
alias frpStart='cd ~/frp_0.56.0_linux_amd64 && nohup ./frps -c frps.toml &'
alias frpStatus='ps -ef | grep frp | grep -v grep'
alias frpLog='cd ~/frp_0.56.0_linux_amd64 && tail -f nohup.out'
alias frpKill="kill $(ps -ef | grep frp | grep -v grep | awk '{print $2}')"
```

## frp windows客户端开启串流

```
# windows客户端命令(用管理员账号执行cmd) 或者新建frt.bat 填入下面代码 右键用管理员身份执行
cd C:\Program Files\frp_0.56.0_windows_amd64
frpc.exe -c frpc.toml
```

## 相关仓库

```
# Sunshine 串流服务端
https://github.com/LizardByte/Sunshine

# ViGEmBus 安装Sunshine时会自动下载安装这个 但无法成Github下载 所以需要手动下载安装 好像是虚拟手柄相关的 不安装可能会有控制的问题
https://github.com/nefarius/ViGEmBus

# Moonlight 串流客户端
https://github.com/moonlight-stream/moonlight-qt

# frp内容穿透 发现这个非常实用 可以做很多事情
https://github.com/fatedier/frp
```