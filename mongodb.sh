#!/bin/bash
clear
#
tar zxvf mongodb-linux-x86_64-3.0.5.tgz
mv /usr/local/src/mongodb-linux-x86_64-3.0.5 /usr/local/mongodb
sed -i '$a PATH=/usr/local/mongodb/bin:$PATH \nexport PATH' /etc/profile
source /etc/profile
mongod --version
echo "============================配置Mongodb=============================="
#建目录
mkdir -p /usr/local/mongodb/data
mkdir -p /usr/local/mongodb/log
mkdir -p /usr/local/mongodb/conf
#建立配置文件
touch /usr/local/mongodb/conf/mongodb.conf
echo -e '#bind_ip=127.0.0.1 \nport=27017 \ndbpath=/usr/local/mongodb/data \nlogpath=/usr/local/mongodb/log/mongodb.log \npidfilepath=/usr/local/mongodb/log/mongodb.pid \ndirectoryperdb=true \nlogappend=true \noplogSize=1000 \nfork=true \n#auth=true \nmaster=true' >> /usr/local/mongodb/conf/mongodb.conf
#增加mongodb用户及设置权限
useradd mongodb -M -s /sbin/nologin
chown -R mongodb.mongodb /usr/local/mongodb
#启动服务
mongod -f /usr/local/mongodb/conf/mongodb.conf 
#编写服务器启动脚本
touch /etc/init.d/mongod
 
#赋予脚本执行权限
chmod +x /etc/init.d/mongod
#重启服务
/etc/init.d/mongod restart
#
netstat -tunlp |grep mong
#添加到开机自启动
chkconfig --add mongod
chkconfig mongod on
 
#URL：http://www.centoscn.com/CentosServer/sql/2015/0806/5967.html
#mongodb配置文件的参数说明
#mongodb的参数说明：
#--dbpath        数据库路径(数据文件)
#--logpath       日志文件路径
#--master        指定为主机器
#--slave         指定为从机器
#--source        指定主机器的IP地址
#--pologSize     指定日志文件大小不超过64M.因为resync是非常操作量大且耗时，最好通过设置一个足够大的oplogSize来避免resync(默认的 oplog大小是空闲磁盘大小的5%)。
#--logappend     日志文件末尾添加
#--port          启用端口号
#--fork          在后台运行
#--only          指定只复制哪一个数据库
#--slavedelay    指从复制检测的时间间隔
#--auth          是否需要验证权限登录(用户名和密码)