# ubuntu desktop 安装kvm
> kvm 虚拟机的安装和使用

## 安装步骤

```
sudo apt install -y cpu-checker

kvm-ok

sudo apt install -y qemu-kvm virt-manager libvirt-daemon-system virtinst libvirt-clients bridge-utils

sudo systemctl enable --now libvirtd
sudo systemctl start libvirtd

sudo systemctl status libvirtd

sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER
```

详见原文：

> Ubuntu 22.04 之 KVM 安装 https://linux.cn/article-14661-1.html
> https://www.linuxtechi.com/how-to-install-kvm-on-ubuntu-22-04/


## 再次启动 default 网络未激活问题

执行下列操作:

```
virsh net-define /usr/share/libvirt/networks/default.xml 
virsh net-start default
```

也可以设置网络自动启动:

```
virsh net-autostart default
```

参考文章: 

> https://blog.csdn.net/a174817529/article/details/40379463
> http://bloodiron888.blog.163.com/blog/static/1647332712010102295930204/

![Visitor Count](https://profile-counter.glitch.me/liuyibao/count.svg)