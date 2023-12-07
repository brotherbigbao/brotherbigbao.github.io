# macOS Catalina 10.15.7 安装 php7.1
> macOS安装老版本PHP

## 安装步骤

- 直接brew安装

```
brew tap shivammathur/php

brew install shivammathur/php/php@7.1
```

- 期间报错下面错误，则手动安装下curl， 系统本身自带有curl，不知道为什么还需要手动装一次

```
Homebrew-installed `curl` is not installed for: https://www.freetds.org/files/stable/freetds-1.3.18.tar.bz2Homebrew-installed 

brew install curl
```

- 安装成功后会显示环境变量配置方法(brew info php@7.1 也会显示下面的提示信息)：

```
==> Checking for dependents of upgraded formulae...
Disable this behaviour by setting HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
==> No broken dependents to reinstall!
==> Caveats
==> php@7.1
To enable PHP in Apache add the following to httpd.conf and restart Apache:
    LoadModule php7_module /usr/local/opt/php@7.1/lib/httpd/modules/libphp7.so

    <FilesMatch \.php$>
        SetHandler application/x-httpd-php
    </FilesMatch>

Finally, check DirectoryIndex includes index.php
    DirectoryIndex index.php index.html

The php.ini and php-fpm.ini file can be found in:
    /usr/local/etc/php/7.1/

php@7.1 is keg-only, which means it was not symlinked into /usr/local,
because this is an alternate version of another formula.

If you need to have php@7.1 first in your PATH, run:
  echo 'export PATH="/usr/local/opt/php@7.1/bin:$PATH"' >> ~/.zshrc
  echo 'export PATH="/usr/local/opt/php@7.1/sbin:$PATH"' >> ~/.zshrc

For compilers to find php@7.1 you may need to set:
  export LDFLAGS="-L/usr/local/opt/php@7.1/lib"
  export CPPFLAGS="-I/usr/local/opt/php@7.1/include"

To start shivammathur/php/php@7.1 now and restart at login:
  brew services start shivammathur/php/php@7.1
Or, if you don't want/need a background service you can just run:
  /usr/local/opt/php@7.1/sbin/php-fpm --nodaemonize
```

- 在我的 .bash_aliases 中配置下面关键代码（我这个脚本是多台设备共用的，普通使用不需要判断是否是mac）

```
#是mac
if [ '/Users/yourname' = "$HOME" ];then
  export PATH="/usr/local/opt/php@7.1/bin:$PATH"
  export PATH="/usr/local/opt/php@7.1/sbin:$PATH"
  export LDFLAGS="-L/usr/local/opt/php@7.1/lib"
  export CPPFLAGS="-I/usr/local/opt/php@7.1/include"
fi
```

- 新终端检查下是否生效

```
➜  ~ which php
/usr/local/opt/php@7.1/bin/php

➜  ~ which php-config
/usr/local/opt/php@7.1/bin/php-config

➜  ~ which pecl
/usr/local/opt/php@7.1/bin/pecl

➜  ~ php-config
Usage: /usr/local/opt/php@7.1/bin/php-config [OPTION]
Options:
  --prefix            [/usr/local/Cellar/php@7.1/7.1.33_7]
  --includes          [-I/usr/local/Cellar/php@7.1/7.1.33_7/include/php -I/usr/local/Cellar/php@7.1/7.1.33_7/include/php/main -I/usr/local/Cellar/php@7.1/7.1.33_7/include/php/TSRM -I/usr/local/Cellar/php@7.1/7.1.33_7/include/php/Zend -I/usr/local/Cellar/php@7.1/7.1.33_7/include/php/ext -I/usr/local/Cellar/php@7.1/7.1.33_7/include/php/ext/date/lib]
  --ldflags           [ -L/usr/local/Cellar/krb5/1.21/lib -L/usr/local/opt/openssl@1.1/lib -L/usr/local/opt/sqlite/lib -L/usr/local/Cellar/curl/8.1.2/lib -L/usr/local/opt/curl/lib -L/usr/local/opt/webp/lib -L/usr/local/opt/jpeg/lib -L/usr/local/opt/libpng/lib -L/usr/local/opt/freetype/lib -L/usr/local/opt/gettext/lib -L/usr/local/opt/gmp/lib -L/usr/local/Cellar/icu4c/72.1/lib -L/usr/local/opt/openldap/lib -L/usr/local/opt/unixodbc/lib -L/usr/local/opt/freetds/lib -L/usr/local/opt/libpq/lib -L/usr/local/opt/aspell/lib -L/usr/local/opt/tidy-html5/lib -L/usr/local/Cellar/libzip/1.9.2/lib]
  --libs              [  -lcrypto -lssl -lcrypto -lzip -lz -lexslt -ltidy -lresolv -ledit -lncurses -laspell -lpspell -lpq -lsqlite3 -lpq -lsybdb -lldap -llber -lstdc++ -liconv -liconv -lgmp -lintl -lpng -lz -ljpeg -lwebp -lcrypto -lssl -lcrypto -lcurl -lbz2 -lz -lsqlite3 -lcrypto -lssl -lcrypto -lm  -lxml2 -lz -licucore -lm -lgssapi_krb5 -lkrb5 -lk5crypto -lcom_err -lcurl -lxml2 -lz -licucore -lm -lfreetype -licui18n -licuuc -licudata -licuio -lodbc -lodbc -lxml2 -lz -licucore -lm -lxml2 -lz -licucore -lm -lxml2 -lz -licucore -lm -lxml2 -lz -licucore -lm -lxml2 -lz -licucore -lm -lxml2 -lz -licucore -lm -lxml2 -lz -licucore -lm -lxslt -lxml2 -lz -licucore -lm ]
  --extension-dir     [/usr/local/Cellar/php@7.1/7.1.33_7/pecl/20160303]
  --include-dir       [/usr/local/Cellar/php@7.1/7.1.33_7/include/php]
  --man-dir           [/usr/local/Cellar/php@7.1/7.1.33_7/share/man]
  --php-binary        [/usr/local/Cellar/php@7.1/7.1.33_7/bin/php]
  --php-sapis         [ apache2handler cli fpm phpdbg cgi]
  --configure-options [--prefix=/usr/local/Cellar/php@7.1/7.1.33_7 --localstatedir=/usr/local/var --sysconfdir=/usr/local/etc/php/7.1 --with-config-file-path=/usr/local/etc/php/7.1 --with-config-file-scan-dir=/usr/local/etc/php/7.1/conf.d --with-pear=/usr/local/Cellar/php@7.1/7.1.33_7/share/php@7.1/pear --enable-bcmath --enable-calendar --enable-dba --enable-exif --enable-ftp --enable-fpm --enable-intl --enable-mbregex --enable-mbstring --enable-mysqlnd --enable-opcache-file --enable-pcntl --enable-phpdbg --enable-phpdbg-webhelper --enable-shmop --enable-soap --enable-sockets --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-wddx --enable-zip --with-apxs2=/usr/local/opt/httpd/bin/apxs --with-curl=/usr/local/opt/curl --with-fpm-user=_www --with-fpm-group=_www --with-freetype-dir=/usr/local/opt/freetype --with-gd --with-gettext=/usr/local/opt/gettext --with-gmp=/usr/local/opt/gmp --with-iconv=/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/usr --with-icu-dir=/usr/local/opt/icu4c --with-jpeg-dir=/usr/local/opt/jpeg --with-kerberos=/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/usr --with-layout=GNU --with-ldap=/usr/local/opt/openldap --with-ldap-sasl=/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/usr --with-libzip --with-mhash=/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/usr --with-mysql-sock=/tmp/mysql.sock --with-mysqli=mysqlnd --with-openssl=/usr/local/opt/openssl@1.1 --with-pdo-dblib=/usr/local/opt/freetds --with-pdo-mysql=mysqlnd --with-pdo-odbc=unixODBC,/usr/local/opt/unixodbc --with-pdo-pgsql=/usr/local/opt/libpq --with-pdo-sqlite=/usr/local/opt/sqlite --with-pgsql=/usr/local/opt/libpq --with-pic --with-png-dir=/usr/local/opt/libpng --with-pspell=/usr/local/opt/aspell --with-sqlite3=/usr/local/opt/sqlite --with-tidy=/usr/local/opt/tidy-html5 --with-unixODBC=/usr/local/opt/unixodbc --with-webp-dir=/usr/local/opt/webp --with-xmlrpc --enable-dtrace --with-bz2=/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/usr --with-libedit=/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/usr --with-libxml-dir=/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/usr --with-ndbm=/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/usr --with-xsl=/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/usr --with-zlib=/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/usr]
  --version           [7.1.33]
  --vernum            [70133]
```

- 安装我的扩展(注意一定要检查环境变更已经配置好， 否则可能会串到系统默认的php环境)

```
➜  ~ pecl install ssh2

WARNING: channel "pecl.php.net" has updated its protocols, use "pecl channel-update pecl.php.net" to update
downloading ssh2-1.4.tgz ...
Starting to download ssh2-1.4.tgz (34,139 bytes)
.........done: 34,139 bytes
6 source files, building
running: phpize
Configuring for:
PHP Api Version:         20160303
Zend Module Api No:      20160303
Zend Extension Api No:   320160303

...

Build process completed successfully
Installing '/usr/local/Cellar/php@7.1/7.1.33_7/pecl/20160303/ssh2.so'
install ok: channel://pecl.php.net/ssh2-1.4
Extension ssh2 enabled in php.ini
```

扩展安装成功，配置文件也自动更改了

![Visitor Count](https://profile-counter.glitch.me/brotherbigbao/count.svg)