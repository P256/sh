#http://blog.chinaunix.net/uid-25266990-id-3380929.html

!/usr/bin/bash
clear
#source res.sh
######################################################################################################
echo "2.设置zabbix目录"
zabbixPath=/usr/local/zabbix
zabbixBin=${zabbixPath}/bin
zabbixEtc=${zabbixPath}/etc
zabbixLog=/data/log/zabbix
# 创建目录
mkdir ${zabbixPath} ${zabbixEtc} ${zabbixLog}
# 设置zabbix用户
zabbixUser=zabbix
zabbixGroup=zabbix
# 创建用户(组)赋予家目录
groupadd -r ${zabbixUser}
useradd -g ${zabbixUser} -s /sbin/nologin -M ${zabbixGroup}
# 赋予权限
chown -R ${zabbixUser}:${zabbixGroup} ${zabbixPath} ${zabbixLog}
#######################################################################################################
echo "3.进入源码目录"
# 进入源码目录
cd /usr/local/src
# 解决依赖包Net-SNMP
yum install net-snmp-devel
#
curl -O https://nchc.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/3.2.6/zabbix-3.2.6.tar.gz
#
zabbixFile=zabbix-3.2.6.tar.gz
zabbixFileDir=zabbix-3.2.6
tar zxf $zabbixFile
cd $zabbixFileDir
./configure --prefix=$zabbixPath --with-mysql --with-net-snmp --with-libcurl --enable-server --enable-agent --enable-proxy
make
make install

# 添加服务端口
vi /etc/services
#zabbix-agent    10050/tcp               # Zabbix Agent
#zabbix-agent    10050/udp               # Zabbix Agent
#zabbix-trapper  10051/tcp               # Zabbix Trapper
#zabbix-trapper  10051/udp               # Zabbix Trapper

# 授权
chown -R $zabbixUser:$zabbixGroup $zabbixPath

# 登录数据库,创建帐号和设置权限
#mysql->CREATE DATABASE zabbix CHARACTER SET utf8;
#mysql->GRANT ALL PRIVILEGES ON zabbix.* TO zabbix@'localhost' IDENTIFIED BY 'zabbix101';

# 导入数据库表
cd database/mysql
mysql -uroot -p'' zabbix < schema.sql
mysql -uroot -p'' zabbix < images.sql
mysql -uroot -p'' zabbix < data.sql

# 修改server配置文件,添加zabbix数据库密码
vi $zabbixEtc/zabbix_server.conf
#LogFile=$zabbixLog/zabbix_server.log
#PidFile=$zabbixLog/zabbix_server.pid
#DBName=zabbix
#DBUser=zabbix
#DBPassword=zabbix101
#ListenIP=192.168.8.8

# 修改Agentd配置文件,更改HOSTNAME为本机的hostname
vi $zabbixEtc/zabbix_agentd.conf
#PidFile=$zabbixLog/zabbix_agentd.pid #进程PID
#LogFile=$zabbixLog/zabbix_agentd.log #日志保存位置
#EnableRemoteCommands=1 #允许执行远程命令
#Server=192.168.8.8 #agent端的ip
#Hostname=zabbix server #必须与zabbix创建的host name相同

# 设置开启自动启动
vi /etc/rc.d/rc.local
# 最后添加下面两行
#/usr/local/zabbix/sbin/zabbix_server
#/usr/local/zabbix/sbin/zabbix_agentd

# 拷贝前端
cp -r frontends/php/ /data/web/zabbix

# web前端安装配置,需修改PHP相关参数
vi php.ini
memory_limit = 128M
post_max_size = 16M
max_execution_time = 300
max_input_time = 300
date.timezone = Asia/Shanghai
mbstring.func_overload=2

databases support



