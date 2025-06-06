# VMware pro 17 安装 Ubuntu 24 的各种问题
> VMware pro 17 安装 Ubuntu 24 的各种问题

本文转自：[https://www.yueproject.com/posts/VMware-pro-17-%E5%AE%89%E8%A3%85%E8%99%9A%E6%8B%9F%E6%9C%BA%E9%97%AE%E9%A2%98/](https://www.yueproject.com/posts/VMware-pro-17-%E5%AE%89%E8%A3%85%E8%99%9A%E6%8B%9F%E6%9C%BA%E9%97%AE%E9%A2%98/)

## 安装 Ubuntu 24 出现闪屏现象

用 VMware pro 17.x 安装 Ubuntu 24 时出现闪屏，安装完成后直接黑屏的现象，大概是 Ubuntu 中对 3D图像加速不完善所造成的。

解决方案：

1.在虚拟机关机的情况下选中当前虚拟机，打开虚拟机设置-显示，先把 3D图像 的选项关闭。

2.开启虚拟机添加 Graphics Drivers PPA
```
sudo add-apt-repository ppa:oibaf/graphics-drivers
```
3.更行和升级
```
sudo apt update && sudo apt upgrade
```
4.关闭虚拟机，然后将 3D 图像 选项重新打开

来源：

[https://askubuntu.com/questions/1515938/how-to-fix-freezing-ubuntu-24-04-on-vmware-and-enable-accelerated-graphics](https://askubuntu.com/questions/1515938/how-to-fix-freezing-ubuntu-24-04-on-vmware-and-enable-accelerated-graphics)

## 安装 open-vm-tools

对于较新的 Linux 发行版，系统会提示用户选择集成的 open-vm-tools，较老的 linux 还是需要使用 vmware tools

```
sudo apt-get update
sudo su
# 这个装上之后虚机就有了显示驱动，屏幕可以自适应大小
apt-get install open-vm-tools
# 作用主要是主机和虚拟机之间的复制粘贴。其实，大文件的拖放也可以利用Share文件夹。
apt-get install open-vm-tools-desktop
reboot
```

安装完后可以实现主机和虚拟机之间的复制粘贴，但是拖放文件到虚拟机要另外设置

# 要查看是否安装了 open-vm-tools，你可以执行以下步骤：

打开终端并登录到 Ubuntu 虚拟机。

运行命令来检查是否已经安装了 open-vm-tools。
```
dpkg -l	grep open-vm-tools
```

如果输出结果中包含 open-vm-tools，那么 VMware Tools 已经安装。

1.如果你使用的是 VMware Workstation 或者 VMware Fusion，你还可以在虚拟机菜单中选择“VM” -> “Install VMware Tools”来安装 VMware Tools。

2.如果你需要重新安装 VMware Tools，可以卸载现有的 VMware Tools，然后重新运行 VMware Tools 安装程序。 卸载 VMware Tools 的命令如下：

```
sudo vmware-uninstall-tools.pl
```

然后重新启动虚拟机，再次运行 VMware Tools 安装程序即可。

# VMware pro 17.x 找不到共享文件夹问题

在 VMware pro 17.x 中安装了 ubuntu 24 ，然后开启了共享却发现找不到此共享文件夹，这是因为还需要设置挂在文件权限问题。

具体命令如下：

```
sudo mount -t fuse.vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other
```

- /mnt/hgfs/ 是挂载点，我们也可以修改为其它挂载点
- -o allow_other 表示普通用户也能访问共享目录
若出现问找到命令的情况，那么可能是缺少 /mnt/hgfs 两个文件夹，需要手动创建

解决办法有两个：

1.输入此命令
```
sudo mkdir /mnt/hgfs/
```

2.如果权限不够，否则拒绝添加。则使用终极大招，直接在你的home下新建文件夹
```
sudo mkdir /home/yousystemname/mnt/
```

然后执行

```
sudo mount -t fuse.vmhgfs-fuse .host:/ /home/yousystemname/mnt/ -o allow_other
cd /home/yousystemname/mnt/
```

然后，再次进入 /home/yousystemname/mnt/查看 （此刻就可以使用桌面系统操作了）

![Visitor Count](https://profile-counter.glitch.me/brotherbigbao/count.svg)