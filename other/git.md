## 常用命令
#### 远程分支被删除，运行下面命令删除本地的
git pull --prune

## 经典文章收藏
- [理解Git工作流](http://www.ituring.com.cn/article/8667)
- [理解Git工作流原文](https://sandofsky.com/blog/git-workflow.html)
- [Git常用命令 - Chris's Blog](http://askcuix.github.io/blog/2013/05/27/the-git-command/)

```
# 查看被忽略的文件及文件夹
git status --ignored
```

## 意外强制回退一个提交（先确认远程分支没被他人使用）
```
git reset --hard HEAD~1
git push --force
```

## 撤销历史中的某个提交
```
#git revert 撤销 某次操作，此次操作之前和之后的commit和history都会保留，并且把这次撤销作为一次最新的提交
#git revert是提交一个新的版本，将需要revert的版本的内容再反向修改回去，
#版本会递增，不影响之前提交的内容
git revert xxxxxxxx
```

## git add错误时，假如是首次提交，则用git reset HEAD 是没用的，要用下面命令
```
git reset --mixed
```