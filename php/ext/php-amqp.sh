#rabbitmq-c
https://github.com/alanxz/rabbitmq-c/releases/download/v0.8.0/rabbitmq-c-0.8.0.tar.gz
#
tar zxvf rabbitmq-c-0.8.0.tar.gz
cd rabbitmq-c-0.9.0
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/rabbitmq-c ..
make
make install
#
phpize
./configure --with-php-config=/usr/local/php71/bin/php-config --with-amqp --with-librabbitmq-dir=/usr/local/rabbitmq-c
make && make install


