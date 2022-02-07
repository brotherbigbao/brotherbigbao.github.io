# homebrew 相关目录
> homebrew 相关目录

## icu4c 61.1手动下载编译

```
cd Downloads/icu/source
./configure --prefix=/usr/local/Cellar/icu4c/61.1 --disable-samples --disable-tests --enable-static --with-library-bits=64
make
make install
cd /usr/local/opt
mv icu4c icu4c.61.1
ln -s ../Cellar/icu4c/61.1 icu4c
```

## homebrew目录

```
/usr/local/Homebrew: 是这个仓库的代码 https://github.com/Homebrew/brew

/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula
保存实际的ruby脚本，是这个仓库的代码 https://github.com/Homebrew/homebrew-core
可以使用命令 cd $(brew --prefix)/Homebrew/Library/Taps/homebrew/homebrew-core/Formula 切换到这个目录

/usr/local/opt: 安装依赖时会在这个目录下创建软链到Cellar
```

brew style --fix icu4c.rb

https://stackoverflow.com/questions/70335759/brew-install-specific-version-of-a-package-fails