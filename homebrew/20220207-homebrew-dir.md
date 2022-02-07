# homebrew 相关目录
> homebrew 相关目录

## icu4c 61.1手动下载编译

```
cd Downloads/icu/source
./configure --prefix=/usr/local/Cellar/icu4c/61.1 --disable-samples --disable-tests --enable-static --with-library-bits=64
make
make install
```

## homebrew目录

```
/usr/local/Homebrew: 是这个仓库的代码 https://github.com/Homebrew/brew
/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula: 是这个仓库的代码 https://github.com/Homebrew/homebrew-core
/usr/local/opt: 安装依赖时会在这个目录下创建软链到Cellar
```