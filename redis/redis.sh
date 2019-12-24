#!/usr/bin/bash
clear
cd /usr/local/src
#redis目录
prefix=/usr/local/redis
version=redis-stable
#创建目录
mkdir -p ${prefix}
mkdir -p ${prefix}/bin
mkdir -p ${prefix}/etc
mkdir -p ${prefix}/log
mkdir -p /data
mkdir -p /data/redis
mkdir -p /data/redis/6379
#下载
# http://download.redis.io/releases/redis-5.0.5.tar.gz
curl -O http://download.redis.io/releases/${version}.tar.gz
#解压
tar -zxvf ${version}.tar.gz
cd ${version}
#编译前先解决依赖包<gcc,tcl>
yum -y install gcc tcl
#如果不加参数,linux下会报错
make MALLOC=libc
make test
#默认安装到/usr/local/bin目录下
make prefix=${prefix} install
#复制自己定义目录
mv /usr/local/bin/* ${prefix}/bin
#
#####################################################################################################################
#手动复制文件
#拷到指定的目录<redis-benchmark redis-check-aof redis-check-rdb redis-cli redis-sentinel redis-server redis-trib.rb>
#cd src
#cp redis-benchmark redis-check-aof redis-check-rdb redis-cli redis-sentinel redis-server redis-trib.rb ${prefix}/bin
#cd ../
#####################################################################################################################
#
#拷贝配置文件
cp redis.conf ${prefix}/etc/
#sed -i "s/daemonize no/daemonize yes/g" ${prefix}/etc/redis.conf
#${prefix}/bin/redis-server ${prefix}/etc/redis.conf
 
#启动redis
#./redis-server  ../etc/redis.conf
#检测后台进程是否存在
ps -ef |grep redis
 
#检测6379端口是否在监听
netstat -lntp | grep 6379
 
#使用客户端
redis-cli shutdown

# env
export REDIS_HOME=/usr/local/redis
export PATH=$REDIS_HOME/bin:$PATH
 
#配置一个系统服务
#cp utils/redis_init_script /etc/rc.d/init.d/redis
#sed -i -e '1a\chkconfig: 2345 80 90' /etc/rc.d/init.d/redis
#sed -i "s/$EXEC $CONF/$EXEC $CONF &/g" /etc/rc.d/init.d/redis
#sed -i "s:/usr/local:/usr/local/redis:g" /etc/rc.d/init.d/redis
#mkdir -p ${prefix}/run
#sed -i "s:/var/run/redis_:${prefix}/run/:g" /etc/rc.d/init.d/redis
#sed -i "s:/var/run/redis_:${prefix}/run/:g" /etc/rc.d/init.d/redis
#sed -i "s:/etc/redis/:${prefix}/etc/:g" /etc/rc.d/init.d/redis
#sed -e "s:${REDISPORT}:redis:g" /etc/rc.d/init.d/redis
#service redis start
#http://itbilu.com/linux/management/NkbXG9kol.htm