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
sed -i '$a \[swoole\]\nextension=swoole.so' /etc/php.ini
cd ../

######################################################################################################
# redis扩展
# http://pecl.php.net/get/redis-4.1.1.tgz
######################################################################################################
curl -O http://pecl.php.net/get/redis-4.1.1.tgz
tar -zxf redis-4.1.1.tgz
cd redis-4.1.1
phpize
./configure --with-php-config=php-config
make
make test
make install
#在文件php.ini中最后一行直接输入extension=redis.so
sed -i '$a \[redis\]\nextension=redis.so' /etc/php.ini
cd ../

######################################################################################################
# amqp扩展
# http://pecl.php.net/get/redis-4.1.1.tgz
######################################################################################################
# rabbitmq-c
curl -O https://github.com/alanxz/rabbitmq-c/releases/download/v0.8.0/rabbitmq-c-0.8.0.tar.gz
#
tar zxvf rabbitmq-c-0.8.0.tar.gz
cd rabbitmq-c-0.8.0
./configure --prefix=/usr/local/rabbitmq-c
make
make install
#
curl -O http://pecl.php.net/get/amqp-1.9.3.tgz
phpize
./configure --with-php-config=/usr/local/php71/bin/php-config --with-amqp --with-librabbitmq-dir=/usr/local/rabbitmq-c
make && make install


