# ubuntu desktop 作为开发机 尝试使用ibus-rime输入法
> ibus-rime 输入法

# 实际使用非常稳定 不会再出现下划线和乱码的情况 不会破坏已经输入的文字

```
sudo apt install ibus-rime

sudo apt install librime-data-wubi

ibus-daemon -drx

ibus-setup //ubuntu22.04就用自带的输入法配置界面吧
```

> https://github.com/rime/librime
> https://github.com/rime/ibus-rime
> https://github.com/rime/home/wiki/RimeWithIBus