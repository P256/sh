#
# rabbitmq-c
curl -O https://github.com/alanxz/rabbitmq-c/releases/download/v0.8.0/rabbitmq-c-0.8.0.tar.gz
#
tar zxvf rabbitmq-c-0.8.0.tar.gz
cd rabbitmq-c-0.8.0
./configure --prefix=/usr/local/rabbitmq-c
make
make install
#

# amqp
curl -O http://pecl.php.net/get/amqp-1.9.3.tgz
phpize
./configure --with-php-config=/usr/local/php71/bin/php-config --with-amqp --with-librabbitmq-dir=/usr/local/rabbitmq-c
make && make install

