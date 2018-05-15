!/usr/bin/bash
clear
#source res.sh
######################################################################################################
echo "2.设置php目录"
phpPath=/usr/local/php
phpBin=${phpPath}/bin
phpEtc=${phpPath}/etc
phpData=/data/php
phpLog=/data/log/php
# 创建目录
mkdir ${phpPath} ${phpEtc} ${phpData} ${phpLog}
# 设置php用户
phpUser=php
phpGroup=php
# 创建用户(组)赋予家目录
groupadd -r ${phpUser}
useradd -g ${phpUser} -r -s /sbin/nologin -M -d ${phpData} ${phpGroup}
# 赋予权限
chown -R ${phpUser}:${phpGroup} ${phpPath} ${phpEtc} ${phpData} ${phpLog}
#######################################################################################################
echo "3.进入源码目录"
# 进入源码目录
cd /usr/local/src
#######################################################################################################
echo "常用扩展需解决依赖-<libxml2,libcurl,libpng,libjpeg,freetype,libmcrypt,openssl,mysql>"
# 
# 1.YUM源方式解决依赖-<libicu,libxml2,libcurl,libpng,libjpeg,freetype,openssl>
#
yum -y install libicu-devel libxml2-devel libcurl-devel libpng-devel libjpeg-devel freetype-devel openssl-devel
#
# 2.二进制源方式解决依赖-<mysql-devel,libmcrypt-devel>
#
# 下载：ftp://mcrypt.hellug.gr/pub/crypto/mcrypt/libmcrypt/libmcrypt-2.5.7.tar.gz
#
libmcryptFile=libmcrypt-2.5.7.tar.gz
libmcryptFileDir=libmcrypt-2.5.7
curl -O ftp://mcrypt.hellug.gr/pub/crypto/mcrypt/libmcrypt/${libmcryptFile}
# 解压
tar -zxf ${libmcryptFile}
cd ${libmcryptFileDir}
./configure --prefix=/usr/local/libmcrypt
make
make install
cd ../
#
echo "4.安装PHP"
# 下载
#http://cn2.php.net/distributions/php-7.1.8.tar.gz 
phpFile=php-7.1.8.tar.gz
phpFileDir=php-7.1.8
curl -O http://cn2.php.net/distributions/${phpFile}
# 解压
tar -zxf ${phpFile}
cd ${phpFileDir}
#
# 查编译配置参数
./configure --help > php-configure.txt
# 编译配置<精简版本>
#./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=php --with-fpm-group=php --disable-all

# 常用编译配置
./configure --prefix=${phpPath} --with-config-file-path=${phpEtc} --enable-fpm --with-fpm-user=${phpUser} --with-fpm-group=${phpGroup} --with-mysqli --enable-embedded-mysqli --enable-mysqlnd --enable-mysqlnd-compression-support --enable-pdo --with-pdo-mysql --with-gd --enable-gd-native-ttf --with-jpeg-dir --with-png-dir --with-freetype-dir --with-zlib --with-openssl --with-curl --with-mcrypt=/usr/local/libmcrypt --with-mhash --with-iconv --enable-zip --enable-inline-optimization --enable-shared --enable-mbstring --enable-mbregex --enable-pcntl --enable-sockets --enable-shmop --enable-sysvsem --enable-sysvshm --enable-session --enable-fileinfo --enable-opcache --enable-opcache-file --enable-huge-code-pages --enable-ctype --enable-intl --enable-dom --enable-libxml --enable-bcmath --enable-xmlwriter --enable-xmlreader --with-gettext --enable-hash --enable-json --disable-all
#
make
make test
make install
cp php.ini-development ${phpEtc}/php.ini
cd ../
#${phpBin}/php -S 192.168.8.8:80 info.php

#
# 配置环境变量
sed -i '$a PHP_PATH='${phpPath} /etc/profile
sed -i '$a PATH=$PATH:$PHP_PATH/bin:$PHP_PATH/sbin' /etc/profile
sed -i '$a export PATH PHP_PATH' /etc/profile
source /etc/profile
#
echo "防火墙开启80端口"
#
# 防火墙开启80端口
# 命令含义
# --zone #作用域 
# --add-port=80/tcp  #添加端口，格式为：端口/通讯协议
# --permanent   #永久生效，没有此参数重启后失效
firewall-cmd --zone=public --add-port=80/tcp --permanent
# 重启防火墙
firewall-cmd --reload

# 常用编译参数
#######################################################################################################
#./configure
#--prefix=${phpPath}
#--with-config-file-path=${etc}	#PHP.ini配置文件位置
#--enable-fpm					#启用fpm SAPI执行方式
#--with-fpm-user				#fpm运行用户<默认nobody>
#--with-fpm-group				#fpm运行用户组<默认nobody>
#--with-mysql					#扩展mysql的支持<php7中该参数已废除>
#--enable-pdo					#扩展pdo的支持
#--with-pdo-mysql				#扩展pdo-mysql的支持
#--with-gd						#扩展gd的支持
#--enable-gd-native-ttf			#启用支持TrueType字符串函数库
#--with-jpeg-dir				#扩展jpeg图片的支持
#--with-png-dir					#扩展png图片的支持
#--with-freetype-dir			#扩展freetype字体库的支持
#--with-zlib					#扩展zlib的支持
#--with-openssl					#扩展openssl的支持
#--with-curl					#扩展curl浏览工具的支持
#--with-mcrypt					#扩展mcrypt算法的支持
#--with-mhash					#扩展mhash算法的扩展
#--with-iconv					#扩展iconv函数,字符集间转换
#--with-libxml-dir				#扩展libxml2库的支持
#--with-xmlrpc					#扩展xmlrpc-epid的支持
#--with-gettext					#扩展gnu的gettext支持,编码库用到
#
#--without-gdbm					#不扩展dba的gdbm支持
#--without-pear					#不扩展pear命令的支持<PHP扩展用的>
#
#--enable-zip					#启用zip的支持
#--enable-inline-optimization	#启用优化线程
#--enable-shared				#启用编译共享库
#--enable-bcmath				#启用图片大小调整,用到zabbix监控的时候用到了这个模块
#--enable-mbstring				#启用多字节,字符串的支持
#--enable-mbregex				#启用mbregex的支持
#--enable-ftp					#启用ftp的支持
#--enable-pcntl					#启用进程控制的支持<CLI/CGI>
#--enable-sockets				#启用sockets的支持
#--enable-shmop					#启用共享内存块
#--enable-sysvsem				#启用系统V信号支持
#--enable-sysvshm				#启用系统V共享内存支持
#--enable-libxml				#启用libxml的支持<默认是disable>
#--enable-xml					#启用xml的支持<需libxml>
#--enable-soap					#启用SOAP的支持<需libxml>
#--enable-session				#启用session的支持
#--enable-fileinfo				#启用fileinfo的支持
#
#--disable-rpath				#关闭额外的运行库文件
#--disable-debug				#关闭调试模式<默认启用状态:一般不会使用,除非在开发PHP程序时比较有用.它可以显示额外的错误信息>
#--disable-all					#关闭默认启用的所有扩展
#
#######################################################################################################
