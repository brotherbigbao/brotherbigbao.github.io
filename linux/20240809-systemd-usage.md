# 使用 systemd
> 使用 systemd

## 当修改service配置时，应该怎么使其生效

```shell
# 重新加载 systemd 配置
systemctl daemon-reload

# 检查服务配置的有效性
systemctl check myservice.service

# 重启服务
systemctl restart myservice.service

# 检查服务状态
systemctl status myservice.service
```

![Visitor Count](https://profile-counter.glitch.me/brotherbigbao/count.svg)