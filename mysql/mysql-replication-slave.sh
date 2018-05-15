#!/usr/bin/bash
clear
mkdir /data/binlogs
chown -R mysql:mysql /data/binlogs/
# 编辑配置文件[mysqld]段增加如下内容
##########################################################################
# Replication Slave Server
# 1.基于POS复制方式
# 2.基于GTID复制方式
##########################################################################
vi etc/my.cnf
###########################################
# 基于GTID同步需配置如下参数(require)
gtid-mode = ON
enforce-gtid-consistency = ON
###########################################
# 服务器标志号
server-id = 2
# 若从库作为其他的主库,可开启使用二进制log,单个从库则不需要.
log-bin =/data/binlogs/slaves-bin
log_slave_updates = 1
read_only = 1
# 中继日志的名称
relay_log = /data/binlogs/slaves-relay-bin
###############################################################################################
# 重启mysql
service mysqld restart
# 登录mysql
mysql -u root -p
###############################################################################################
# 配置从服务器
###############################################################################################
# 停止slave
#STOP SLAVE;
# 1.基于POS复制方式
#CHANGE MASTER TO MASTER_HOST = '192.168.8.8', MASTER_USER = 'slave', MASTER_PASSWORD = 'g+DI?a.#j65=', MASTER_LOG_FILE = 'master-bin.000001', MASTER_LOG_POS = 0;
# 2.基于GTID复制方式
#CHANGE MASTER TO MASTER_HOST = '192.168.8.8', MASTER_USER = 'slave', MASTER_PASSWORD = 'g+DI?a.#j65=', MASTER_AUTO_POSITION=1;
# 开启slave
#START SLAVE;

# 查看slave的状态
#SHOW SLAVE STATUS;
# Slave_IO_Running=Yes
# Slave_SQL_Running=Yes
#SHOW PROCESSLIST;
# 应该有两行state值为：
# Waiting for master to send event
# Slave has read all relay log; waiting for the slave I/O thread to update it

