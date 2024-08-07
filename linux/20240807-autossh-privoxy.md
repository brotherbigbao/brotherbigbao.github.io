# privoxy 配合 autossh，由于socks5监听的是0.0.0.0，这里也必须是 0.0.0.0
> privoxy 配合 autossh

## 最佳实践
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

## 配置文件

主配置文件： /etc/privoxy/config

# 默认日志目录：

/var/log/privoxy

# 打开 debug, 将1和1024取消注释即可

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

注意别忘了关掉日志