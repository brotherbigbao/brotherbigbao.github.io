# privoxy 配合 autossh，由于socks5监听的是0.0.0.0，这里也必须是 0.0.0.0
> privoxy 配合 autossh

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
```