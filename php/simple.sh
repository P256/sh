#下载二进制包
curl -O https://www.php.net/distributions/php-7.1.32.tar.xz

#安装编译php7时需要的依赖包
yum -y install libxml2 libxml2-devel openssl openssl-devel curl-devel libjpeg-devel libpng-devel freetype-devel libmcrypt-devel

#添加web
adduser web

#启用intl扩展需先安装依赖包
#yum -y install libicu libicu-devel

#
#[可选] --exec-prefix=/usr/local/php --bindir=/usr/local/php/bin --sbindir=/usr/local/php/sbin --includedir=/usr/local/php/include --libdir=/usr/local/php/lib/php --mandir=/usr/local/php/php/man 
#
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-mysqli=shared,mysqlnd --with-pdo-mysql=shared,mysqlnd --with-mysql-sock=/var/run/mysql/mysql.sock --with-gd --with-iconv --with-zlib --with-curl --with-jpeg-dir --with-freetype-dir --with-gettext --with-xmlrpc --with-openssl --with-mhash --with-mcrypt=/usr/include --with-pear --without-gdbm --enable-zip --enable-inline-optimization --enable-shared --enable-xml --enable-bcmath --enable-shmop --enable-sysvsem --enable-mbregex --enable-mbstring --enable-ftp --enable-gd-native-ttf --enable-pcntl --enable-sockets --enable-soap --enable-session --enable-opcache --enable-fileinfo --enable-pdo --enable-debug --enable-fpm --with-fpm-user=web --with-fpm-group=web --disable-rpath --enable-intl --with-pdo-mysql --enable-pdo

#
cd /user/local/php

#测试php-fpm配置
./sbin/php-fpm -t
./sbin/php-fpm -c ./etc/php.ini -y ./etc/php-fpm.conf -t

#启动php-fpm
./sbin/php-fpm
./sbin/php-fpm -c ./etc/php.ini -y ./etc/php-fpm.conf




 