#!/usr/bin/bash
clear
lsb_release -a
#进入src
cd /usr/local/src
#php目录
prefix=/usr/local/php
version=7.0.10
etc=${prefix}/etc
#创建目录
mkdir -p ${prefix}
mkdir -p ${etc}
#下载
#http://cn2.php.net/distributions/php-5.6.25.tar.gz
#http://cn2.php.net/distributions/php-7.0.10.tar.gz
#http://cn2.php.net/distributions/php-7.1.0.tar.gz
#http://cn2.php.net/distributions/php-7.1.1.tar.gz
curl -O http://cn2.php.net/distributions/php-${version}.tar.gz
#解压
tar -zxvf php-${version}.tar.gz
cd php-${version}
#编译器必须安装
yum -y install gcc
#精简版本<config/fpm>
./configure --prefix=${prefix} --with-config-file-path=${etc} --enable-fpm --with-fpm-user=web --with-fpm-group=web --disable-all
#./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=web --with-fpm-group=web --disable-all
#############################################################################################################################################################
#常用扩展
#编译前先解决依赖包<libxml2,libcurl,libpng,libjpeg,freetype,libmcrypt,openssl,mysql>
yum -y install libxml2-devel libcurl-devel libpng-devel libjpeg-devel freetype-devel libmcrypt-devel openssl-devel mysql-devel
#<php5.4.45支持--with-mysqli>
#./configure
#--prefix=${prefix}
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
##############################################################################################################################################################
# 自定义
./configure --prefix=${prefix} --with-config-file-path=${etc} --enable-fpm --with-fpm-user=web --with-fpm-group=web --enable-pdo --with-pdo-mysql --with-gd --enable-gd-native-ttf --with-jpeg-dir --with-png-dir --with-freetype-dir --with-zlib --with-openssl --with-curl --with-mcrypt --with-mhash --with-iconv --enable-zip --enable-inline-optimization --enable-shared --enable-mbstring --enable-mbregex --enable-pcntl --enable-sockets --enable-shmop --enable-sysvsem --enable-sysvshm --enable-session --enable-fileinfo --enable-json --disable-all
#手动处理
#./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=web --with-fpm-group=web --enable-pdo --with-pdo-mysql --with-gd --enable-gd-native-ttf --with-jpeg-dir --with-png-dir --with-freetype-dir --with-zlib --with-openssl --with-curl --with-mcrypt --with-mhash --with-iconv --enable-zip --enable-inline-optimization --enable-shared --enable-mbstring --enable-mbregex --enable-pcntl --enable-sockets --enable-shmop --enable-sysvsem --enable-sysvshm --enable-session  --enable-json --enable-fileinfo --disable-all
#
make
make test
make install
cp php.ini-development ${etc}
cd ../
#${prefix}/bin/php -S 192.168.100.109:8080 info.php
##############################################################################################################################################################
##############################################################################################################################################################
#扩展包
bin=${prefix}/bin
##############################################################################################################################################################
#opcache
sed -i '$a [extension]' ${etc}/php.ini
#在文件php.ini中最后一行直接输入extension=opcache.so
sed -i '$a extension=opcache.so' ${etc}/php.ini
##############################################################################################################################################################
#memcache
tar zxvf memcache-2.2.7.tgz
cd memcache-2.2.7
${bin}/phpize ./configure --with-php-config=${bin}/php-config
make
make install
#在文件php.ini中最后一行直接输入extension=memcache.so
sed -i '$a extension=memcache.so' ${etc}/php.ini
cd ../
##############################################################################################################################################################
#libmemcached依赖包
tar zxvf libmemcached-1.0.18.tar.gz
cd libmemcached-1.0.18
./configure --prefix=/usr/local/libmemcached
make 
make install
cd ../
#memcached
tar zxvf memcached-2.2.0.tgz
cd memcached-2.2.0
${bin}/phpize ./configure --with-libmemcached-dir=/usr/local/libmemcached --disable-memcached-sasl
make
make install
#在文件php.ini中最后一行直接输入extension=memcached.so
sed -i '$a extension=memcached.so' ${etc}/php.ini
cd ../
#mysqlnd_memcache
#tar zxvf mysqlnd_memcache-1.0.1.tgz
#cd mysqlnd_memcache-1.0.1
#${bin}/phpize ./configure --with-php-config=/usr/local/php/bin/php-config --with-libmemcached-dir=/usr/local/libmemcached
#make
#make install
#在文件php.ini中最后一行直接输入extension=mysqlnd_memcache.so
#sed -i '$a extension=mysqlnd_memcache.so' /usr/local/php/etc/php.ini
#cd ../
##############################################################################################################################################################
#redis
tar zxvf redis-2.2.7.tgz
cd redis-2.2.7
${bin}/phpize ./configure --with-php-config=${bin}/php-config
make
make install
#在文件php.ini中最后一行直接输入extension=redis.so
sed -i '$a extension=redis.so' ${etc}/php.ini
cd ../
##############################################################################################################################################################
#mongo
tar zxvf mongo-1.6.10.tgz
cd mongo-1.6.10
${bin}/phpize ./configure --with-php-config=${bin}/php-config
make
make install
#在文件php.ini中最后一行直接输入extension=mongo.so
sed -i '$a extension=mongo.so' ${etc}/php.ini
cd ../
##############################################################################################################################################################
#xcache
tar zxvf xcache-3.2.0.tar.gz
cd xcache-3.2.0
${bin}/phpize ./configure --with-php-config=${bin}/php-config
make
make install
#在文件php.ini中最后一行直接输入extension=xcache.so
sed -i '$a extension=xcache.so' ${etc}/php.ini
#配置xcache
sed -i '$a [xcache]\n xcache.cacher = On \nxcache.var_size=0 \nxcache.shm_scheme ="mmap" \nxcache.size=60M \nxcache.count =1 \nxcache.slots =8K \nxcache.ttl=0 \nxcache.gc_interval =0 \nxcache.var_size=4M \nxcache.var_count =1 \nxcache.var_slots =8K \nxcache.var_ttl=0 \nxcache.var_maxttl=0 \nxcache.var_gc_interval =300 \nxcache.test =Off \nxcache.readonly_protection = On \nxcache.mmap_path ="/tmp/xcache" \nxcache.coredump_directory ="" \nxcache.cacher =On \nxcache.stat=On \nxcache.optimizer =On \n[xcache.coverager] \nxcache.coverager =On \nxcache.coveragedump_directory ="" \n[xcache.admin] \nxcache.admin.auth = On \nxcache.admin.user = "admin" \nxcache.admin.pass = "21232f297a57a5a743894a0e4a801fc3"' ${etc}/php.ini
#拷贝xcache web管理程序
cp -a htdocs/ /data/web/xcache
cd ../
##############################################################################################################################################################
#pthreads
#tar zxvf pthreads-2.0.10.tgz
#cd pthreads-2.0.10
#${bin}/phpize ./configure --with-php-config=${bin}/php-config
#make
#make install
#cd ../
##############################################################################################################################################################
#xhprof
tar zxvf xhprof-0.9.4.tgz
cd xhprof-0.9.4
cd extension
${bin}/phpize ./configure --with-php-config=${bin}/php-config
make
make install
cd ../
#在文件php.ini中最后一行直接输入extension=xhprof.so
sed -i '$a extension=xhprof.so' ${etc}/php.ini
sed -i '$a [xhprof]\n xhprof.output_dir = /tmp/xhprof \n' ${etc}/php.ini
cd ../
##############################################################################################################################################################
#xdebug
tar zxvf xdebug-2.3.3.tgz
cd xdebug-2.3.3
${bin}/phpize ./configure --with-php-config=${bin}/php-config
make
make install
#在文件php.ini中最后一行直接输入extension=xdebug.so
sed -i '$a extension=xdebug.so' ${etc}/php.ini
#sed -i '$a [xdebug]\n xhprof.output_dir = /tmp/xhprof \n' ${etc}/php.ini
cd ../
##############################################################################################################################################################
