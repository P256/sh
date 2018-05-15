#!/usr/bin/bash
clear
mkdir /data/binlogs
chown -R mysql:mysql /data/binlogs/
vi etc/my.cnf
# 编辑配置文件[mysqld]段填写如下内容
##########################################################################
# Replication Slave Server
##########################################################################
#server-id       	= 2
#relay_log			= /data/binlogs/slaves-relay-bin
#log_slave_updates	= 1
#read_only			= 1
# 若从库作为其他的主库,可开启使用二进制log,单个从库则不需要.
# log-bin				=/data/binlogs/slaves-bin
##########################################################################
# 重启mysql
service mysqld restart
# 登录mysql
mysql -u root -p
###############################################################################################
# 配置从服务器<109>
###############################################################################################
# 停止slave
#STOP SLAVE;
# 设置连接master的binlog
#CHANGE MASTER TO MASTER_HOST = '192.168.1.106', MASTER_USER = 'backup', MASTER_PASSWORD = 'backup', MASTER_LOG_FILE = 'master-bin.000001', MASTER_LOG_POS = 0;
# 开发slave
#START SLAVE;
# 查看slave的状态
#SHOW SLAVE STATUS;
# Slave_IO_Running=Yes
# Slave_SQL_Running=Yes
#SHOW PROCESSLIST;
# 应该有两行state值为：
# Waiting for master to send event
# Slave has read all relay log; waiting for the slave I/O thread to update it