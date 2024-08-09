# privoxy 配合 autossh，由于socks5监听的是0.0.0.0，这里也必须是 0.0.0.0
> privoxy 配合 autossh

## 最佳实践 autossh

- 新增service, root身份 vim /etc/systemd/system/remote-autossh.service

```shell
[Unit]
Description=AutoSSH service for remote tunnel
After=network-online.target
Wants=network-online.target

[Service]
User=root
ExecStart=/usr/bin/autossh -M 7090 -NT -D 0.0.0.0:7070 liuyibao@YOUR_SERVER_IP

[Install]
WantedBy=multi-user.target
```

```
sudo systemctl enable remote-autossh.service
sudo systemctl start remote-autossh.service
sudo systemctl status remote-autossh.service
```

## 最佳实践 privoxy

- 修改 /etc/privoxy/config, 监听ip和端口：
```
listen-address  127.0.0.1:8118
```
改成

```
listen-address  0.0.0.0:8118
```

- 修改 /etc/privoxy/config, 在actionsfile栏添加如下， 引入自定义配置文件：

```
actionsfile whitelist.action # 白名单配置
```

- 新增自定义配置文件

```
cd /etc/privoxy
vim whitelist.action
```

- whitelist.action 详细内容，根据日志不断添加需要代理的域名

```
{{alias}}
direct = +forward-override{forward .}
proxy = +forward-override{forward-socks5 0.0.0.0:7070 .}

{direct}
/

{proxy}
.google.com
.google.com.hk
.youtube.com
.googlevideo.com
.googleapis.com
.gvt2.com
.ytimg.com
.googleusercontent.com
.gstatic.com
.ggpht.com
.youtubekids.com
```

- 其它可疑域名
```shell
.xn--ngstr-lra8j.com #play商店下载会请求这个域名，但是发现这个域名指向的是国内ip，可能是类似下载cdn的东西，暂时不处理，假如play商店下载卡住的话，可以尝试添加这个域名
```

## privoxy 打开 debug, 将1和1024取消注释即可(1:记录所有请求 方便检查添加代理域名，1024记录未通过的请求 默认配置会过滤掉广告域名)

debug     1 # Log the destination for each request. See also debug 1024.
#debug     2 # show each connection status
#debug     4 # show tagging-related messages
#debug     8 # show header parsing
#debug   128 # debug redirects
#debug   256 # debug GIF de-animation
#debug   512 # Common Log Format
debug  1024 # Log the destination for requests Privoxy didn't let through, and the reason why.
#debug  4096 # Startup banner and warnings
#debug  8192 # Non-fatal errors
#debug 65536 # Log applying actions

当所有域名都添加好了，注意别忘了关掉日志，防止日志

## privoxy 相关常识 Linux

主配置文件：/etc/privoxy/config

默认日志目录：/var/log/privoxy/

## privoxy 相关常识 MacOS

```
brew install privoxy
brew services start privoxy
brew services info privoxy
brew services restart privoxy
```

主配置文件：/usr/local/etc/privoxy/config

默认日志目录：/usr/local/var/log/privoxy/

## 远程重启 network 方案

crontab 定时拉取远程文件，文件内容是1时，就重启 autossh、privoxy

minipc_net_restart.sh

*/3 * * * * /root/minipc_net_restart.sh

```shell
#!/bin/bash

sleep 33

cd ~

# 删除本地文件
if [ -f ~/minipc_net_restart.txt ]; then
    rm ~/minipc_net_restart.txt
fi

# 下载远程文件 已上传到oss https://openpublic.oss-cn-shanghai.aliyuncs.com/minipc/minipc_net_restart.txt
#wget -O ~/minipc_net_restart.txt https://openpublic.oss-cn-shanghai.aliyuncs.com/minipc/minipc_net_restart.txt
# 直接使用scp更方便修改
scp liuyibao@YOUR_SERVER_IP:/home/liuyibao/minipc_net_restart.txt ~/minipc_net_restart.txt

# 检查文件内容
if [ "$(cat ~/minipc_net_restart.txt)" = "1" ]; then
    # 重启 remote-autossh 服务
    systemctl restart remote-autossh.service
    sleep 10
    # 重启 privoxy 服务
    systemctl restart privoxy.service
    echo "restart done."
else
    echo "File content is not '1', services will not be restarted."
fi
```

## 定期上报本地更新本地ip地址

minipc_ifconfig.sh

*/5 * * * * /root/minipc_ifconfig.sh

```shell
#!/bin/bash

sleep 47
cd ~

# 定义远程服务器的信息
REMOTE_SERVER=liuyibao@YOUR_SERVER_IP
REMOTE_PATH=/home/liuyibao/

# 执行 ifconfig 命令并将输出保存到本地文件
ifconfig > minipc_ifconfig.txt

# 检查 ifconfig 命令是否成功执行
if [ $? -eq 0 ]; then
    echo "ifconfig command executed successfully."

    # 使用 scp 命令将文件传输到远程服务器
    scp minipc_ifconfig.txt ${REMOTE_SERVER}:${REMOTE_PATH}

    # 检查 scp 命令是否成功执行
    if [ $? -eq 0 ]; then
        echo "File transferred successfully to the remote server."
    else
        echo "Failed to transfer file to the remote server."
    fi
else
    echo "Failed to execute ifconfig command."
fi
```

# 定期上传并清空日志

minipc_privoxy_log.sh

*/30 * * * * /root/minipc_privoxy_log.sh

```shell
#!/bin/bash

# 定义远程服务器的信息
REMOTE_HOST="liuyibao@YOUR_SERVER_IP"
REMOTE_PATH="/home/liuyibao/"
LOCAL_FILE="/var/log/privoxy/logfile"

# 获取当前日期和时间
CURRENT_DATE_TIME=$(date '+%Y%m%d%H%M%S')

# 构建远程文件的完整路径
REMOTE_FILE="${REMOTE_PATH}logfile.${CURRENT_DATE_TIME}.txt"

# 检查本地文件是否存在
if [ -f "$LOCAL_FILE" ]; then
    # SCP 传输文件到远程服务器
    scp "$LOCAL_FILE" "$REMOTE_HOST:$REMOTE_FILE"
    
    # 检查 SCP 传输是否成功
    if [ $? -eq 0 ]; then
        # 清空本地文件的内容
        > "$LOCAL_FILE"
        echo "File transferred successfully and local file cleared."
    else
        echo "SCP transfer failed."
    fi
else
    echo "Local file does not exist."
fi
```


