# Github Personal access token
> git clone https 路径的项目时可能会需要

相关官方文档：

https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories#cloning-with-https-urls

https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens

mac下使用： https://docs.github.com/en/get-started/getting-started-with-git/caching-your-github-credentials-in-git?platform=mac

linux下使用： https://docs.github.com/en/get-started/getting-started-with-git/caching-your-github-credentials-in-git?platform=linux

记忆中只有Mac homebrew 会用到这个， 根据 homebrew 提示操作就行， 配置一个环境变量: HOMEBREW_GITHUB_API_TOKEN

本来以为是代理出了问题，原来是github一个仓库被禁用了。一般用ssh方式 clone 代码不需要这个 token。