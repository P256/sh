#!/bin/bash
 
clear
tar zxvf libevent-2.0.22-stable.tar.gz
cd libevent-2.0.22-stable
./configure --prefix=/usr/local/libevent
make
make install
cd ../
tar zxvf memcached-1.4.24.tar.gz
cd memcached-1.4.24
./configure --prefix=/usr/local/memcached --with-libevent=/usr/local/libevent
make
make install
echo "==========================启动Memcached服务=============================="
mkdir /usr/local/memcached/tmp
sed -i '$a PATH=/usr/local/memcached/bin:$PATH \nexport PATH' /etc/profile
source /etc/profile
memcached -d -m 10 -u root -l 127.0.0.1 -p 11211 -c 256 -P /usr/local/memcached/tmp/memcached.pid
#-d选项是启动一个守护进程，
#-m是分配给Memcache使用的内存数量，单位是MB，我这里是10MB，
#-u是运行Memcache的用户，我这里是root，
#-l是监听的服务器IP地址，如果有多个地址的话，我这里指定了服务器的IP地址127.0.0.1，
#-p是设置Memcache监听的端口，我这里设置了12000，最好是1024以上的端口，
#-c选项是最大运行的并发连接数，默认是1024，我这里设置了256，按照你服务器的负载量来设定，
#-P是设置保存Memcache的pid文件，我这里是保存在 /usr/local/memcached/tmp/memcached.pid，