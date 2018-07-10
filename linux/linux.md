### crontab 命令详解

[IBM Knowledge Center, crontab](https://www.ibm.com/support/knowledgecenter/zh/ssw_aix_71/com.ibm.aix.cmds1/crontab.htm)


### crontab 导出文件和载入文件
```
crontab -l > /tmp/crontab.bak
echo 'something new...' >> /tmp/crontab.bak
crontab /tmp/crontab.bak
```