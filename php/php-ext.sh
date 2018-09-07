######################################################################################################
# 进入源码目录
cd /usr/local/src

######################################################################################################
# swoole扩展
# http://pecl.php.net/get/swoole-4.1.2.tgz
######################################################################################################
curl -O http://pecl.php.net/get/swoole-4.1.2.tgz
tar -zxf swoole-4.1.2.tgz
cd swoole-4.1.2
phpize
./configure --with-php-config=php-config
make
make test
make install
#在文件php.ini中最后一行直接输入extension=swoole.so
sed -i '$a \[redis\]\nextension=swoole.so' /etc/php.ini
cd ../

######################################################################################################
# swoole扩展
# http://pecl.php.net/get/redis-4.1.1.tgz
######################################################################################################
curl -O http://pecl.php.net/get/redis-4.1.1.tgz
tar -zxf swoole-4.1.2.tgz
cd redis-4.1.1
phpize
./configure --with-php-config=php-config
make
make test
make install
#在文件php.ini中最后一行直接输入extension=redis.so
sed -i '$a \[redis\]\nextension=redis.so' /etc/php.ini
cd ../

