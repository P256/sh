!/usr/bin/bash
clear
######################################################################################################
# 动态扩展包
######################################################################################################
#source res.sh
######################################################################################################
phpPath=/usr/local/php
phpBin=${phpPath}/bin
phpEtc=${phpPath}/etc
######################################################################################################
# 源码目录
######################################################################################################
cd /usr/local/src
# opcache扩展
# 在php.ini中查找[opcache],并在下面追加一行extension=opcache.so
sed -i '/\[opcache\]/a\zend_extension=opcache.so' ${phpEtc}/php.ini
######################################################################################################
# 编译扩展需要autoconf支持
######################################################################################################
yum install autoconf
######################################################################################################
# xdebug扩展
# http://pecl.php.net/get/xdebug-2.5.4.tgz
######################################################################################################
phpXdebug=xdebug-2.5.4
curl -O http://pecl.php.net/get/${phpXdebug}.tgz
tar -zxf ${phpXdebug}.tgz
cd ${phpXdebug}
${phpBin}/phpize
./configure --with-php-config=${phpBin}/php-config
make
make test
make install
# 在文件php.ini中最后一行直接输入zend_extension=xdebug.so
sed -i '$a \[xdebug\]\nzend_extension=xdebug.so' ${phpEtc}/php.ini
cd ../
######################################################################################################
# redis扩展
# http://pecl.php.net/get/redis-3.1.2.tgz
######################################################################################################
phpRedis=redis-3.1.2.tgz
curl -O http://pecl.php.net/get/${phpRedis}.tgz
tar -zxf ${phpRedis}.tgz
cd ${phpRedis}
${phpBin}/phpize
./configure --with-php-config=${phpBin}/php-config
make
make test
make install
#在文件php.ini中最后一行直接输入extension=redis.so
sed -i '$a \[redis\]\nextension=redis.so' ${phpEtc}/php.ini
cd ../
######################################################################################################
# memcached扩展-libmemcached
# https://launchpadlibrarian.net/165454254/libmemcached-1.0.18.tar.gz
######################################################################################################
libmemcached=libmemcached-1.0.18
curl -O https://launchpadlibrarian.net/165454254/libmemcached-1.0.18.tar.gz
tar zxf ${libmemcached}.tar.gz
cd ${libmemcached}
./configure --prefix=/usr/local/libmemcached
make
make test
make install
cd ../
######################################################################################################
# memcached扩展
# http://pecl.php.net/get/memcached-3.0.3.tgz
######################################################################################################
phpMemcached=memcached-3.0.3
curl -O http://pecl.php.net/get/${phpMemcached}.tgz
tar -zxf ${phpMemcached}.tgz
cd ${phpMemcached}
${phpBin}/phpize
./configure --with-php-config=${phpBin}/php-config --with-libmemcached-dir=/usr/local/libmemcached --disable-memcached-sasl
make
make test
make install
# 在文件php.ini中最后一行直接输入extension=memcached.so
sed -i '$a \[memcached\]\nextension=memcached.so' ${phpEtc}/php.ini
cd ../
######################################################################################################
# apcu扩展
# http://pecl.php.net/get/apcu-5.1.8.tgz
phpApcu=apcu-5.1.8
curl -O http://pecl.php.net/get/${phpApcu}.tgz
tar -zxf ${phpApcu}.tgz
cd ${phpApcu}
${phpBin}/phpize
./configure --with-php-config=${phpBin}/php-config
make
make test
make install
# 在文件php.ini中最后一行直接输入extension=apcu.so
sed -i '$a \[apcu\]\nextension=apcu.so' ${phpEtc}/php.ini
cd ../
######################################################################################################
# pthreads扩展
# http://pecl.php.net/get/pthreads-3.1.6.tgz
######################################################################################################
phpPthreads=pthreads-3.1.6
curl -O http://pecl.php.net/get/${phpPthreads}.tgz
tar -zxf ${phpPthreads}.tgz
cd ${phpPthreads}
${phpBin}/phpize
./configure --with-php-config=${phpBin}/php-config
make
make test
make install
# 在文件php.ini中最后一行直接输入extension=pthreads.so
sed -i '$a \[pthreads\]\nextension=pthreads.so' ${phpEtc}/php.ini
cd ../
##############################################################################################

# xcache扩展
# mongo扩展
# xhprof










# 此后部分暂不支持PHP7需调整


# mongo扩展
# http://pecl.php.net/get/mongo-1.6.14.tgz
phpMongo=mongo-1.6.14
curl -O http://pecl.php.net/get/${phpMongo}.tgz
tar -zxf ${phpMongo}.tgz
cd ${phpMongo}
${phpBin}/phpize 
./configure --with-php-config=${phpBin}/php-config
make
make test
make install
#在文件php.ini中最后一行直接输入extension=mongo.so
sed -i '$a \[mongo\]\nextension=mongo.so' ${phpEtc}/php.ini
cd ../
#############################################################################################
#memcache
tar xvf memcache-2.2.7.tgz
cd memcache-2.2.7
${phpBin}/phpize ./configure --with-php-config=${phpBin}/php-config
make
make install
#在文件php.ini中最后一行直接输入extension=memcache.so
sed -i '$a extension=memcache.so' ${phpEtc}/php.ini
cd ../
###################################################################################################
#mysqlnd_memcache
#tar zxvf mysqlnd_memcache-1.0.1.tgz
#cd mysqlnd_memcache-1.0.1
#${phpBin}/phpize ./configure --with-php-config=${phpBin}/php-config --with-libmemcached-dir=/usr/local/libmemcached
#make
#make install
#在文件php.ini中最后一行直接输入extension=mysqlnd_memcache.so
#sed -i '$a extension=mysqlnd_memcache.so' ${phpEtc}/php.ini
#cd ../
##################################################################################################
#xcache
tar zxvf xcache-3.2.0.tar.gz
cd xcache-3.2.0
${bin}/phpize ./configure --with-php-config=${bin}/php-config
make
make install
#在文件php.ini中最后一行直接输入extension=xcache.so
sed -i '$a extension=xcache.so' ${phpEtc}/php.ini
#配置xcache
sed -i '$a [xcache]\n xcache.cacher = On \nxcache.var_size=0 \nxcache.shm_scheme ="mmap" \nxcache.size=60M \nxcache.count =1 \nxcache.slots =8K \nxcache.ttl=0 \nxcache.gc_interval =0 \nxcache.var_size=4M \nxcache.var_count =1 \nxcache.var_slots =8K \nxcache.var_ttl=0 \nxcache.var_maxttl=0 \nxcache.var_gc_interval =300 \nxcache.test =Off \nxcache.readonly_protection = On \nxcache.mmap_path ="/tmp/xcache" \nxcache.coredump_directory ="" \nxcache.cacher =On \nxcache.stat=On \nxcache.optimizer =On \n[xcache.coverager] \nxcache.coverager =On \nxcache.coveragedump_directory ="" \n[xcache.admin] \nxcache.admin.auth = On \nxcache.admin.user = "admin" \nxcache.admin.pass = "21232f297a57a5a743894a0e4a801fc3"' ${phpEtc}/php.ini
#拷贝xcache web管理程序
cp -a htdocs/ $phpData/xcache
cd ../
#############################################################################################
#xhprof
tar zxvf xhprof-0.9.4.tgz
cd xhprof-0.9.4
cd extension
${bin}/phpize ./configure --with-php-config=${bin}/php-config
make
make install
cd ../
#在文件php.ini中最后一行直接输入extension=xhprof.so
sed -i '$a extension=xhprof.so' ${phpEtc}/php.ini
sed -i '$a [xhprof]\n xhprof.output_dir = /tmp/xhprof \n' ${phpEtc}/php.ini
cd ../
################################################################################################
