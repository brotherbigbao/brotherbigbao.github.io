# ubuntu desktop 作为开发机的一些操作
> ubuntu desktop 作为开发机的一些操作

# 安装指定php环境

```
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php7.1
```

# 禁用apache2

```
sudo systemctl stop apache2.service
sudo systemctl disable apache2.service
```