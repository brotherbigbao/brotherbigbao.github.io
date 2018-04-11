dpkg -l --列出当前系统中所有的包.可以和参数less一起使用在分屏查看. (类似于rpm -qa)

dpkg -l |grep -i "软件包名" --查看系统中与"软件包名"相关联的包.

apt-cache policy xxxx