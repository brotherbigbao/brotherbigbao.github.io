# Github Personal access token
> git clone https 路径的项目时可能会需要

## 相关官方文档：

https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories#cloning-with-https-urls

https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens

mac下使用： https://docs.github.com/en/get-started/getting-started-with-git/caching-your-github-credentials-in-git?platform=mac

linux下使用： https://docs.github.com/en/get-started/getting-started-with-git/caching-your-github-credentials-in-git?platform=linux

记忆中只有Mac homebrew 会用到这个， 根据 homebrew 提示操作就行， 配置一个环境变量: HOMEBREW_GITHUB_API_TOKEN

本来以为是代理出了问题，原来是github一个仓库被禁用了。一般用ssh方式 clone 代码不需要这个 token。


## 网上找到暂存 personal access token 的方法

在 Ubuntu 中使用 GitHub 的个人访问令牌，您可以这样做：

在 GitHub 网站上生成一个个人访问令牌。

在命令行终端中运行以下命令：

```
$ git config --global user.name "Your Name"
$ git config --global user.email "your_email@example.com"
$ git config --global credential.helper store
```

这将告诉 Git 将凭据存储在本地磁盘上。然后，您可以进行第一次提交，以便 Git 询问您的凭据。请输入您的用户名和个人访问令牌

```
$ git clone https://github.com/user/repo.git
$ cd repo
$ git push
```

Git 应该现在已经使用您的个人访问令牌进行身份验证，并且不会再次询问您的凭据。

原文： https://juejin.cn/s/how%20to%20use%20personal%20access%20token%20github%20ubuntu



![Visitor Count](https://profile-counter.glitch.me/brotherbigbao/count.svg)