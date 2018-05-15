#!/usr/bin/bash
clear
mkdir /data/binlogs
chown -R mysql:mysql /data/binlogs/
# 编辑配置文件[mysqld]段增加如下内容
##################################################################################
# Replication Master Server
# 1.基于POS复制方式
# 2.基于GTID复制方式
##################################################################################
vi etc/my.cnf
###########################################
# 基于GTID同步需配置如下参数(require)
gtid-mode = ON
enforce-gtid-consistency = ON
###########################################
# 服务器标志号
server-id = 1
# 二进制日志的名称
log-bin = /data/binlogs/master-bin
# 二进制日志索引的名称
log_bin_index = /data/binlogs/master-bin.index
# 日志文件格式为: ROW|STATEMENT|MIXED
binlog_format = mixed
# 每个binlog最大大小
max_binlog_size = 500M
# 需要同步的数据库名字,如果是多个,就以此格式在写一行即可
#binlog-do-db = demo
# 不需要同步的数据库名字,如果是多个,就以此格式在写一行即可
#binlog-ignore-db= mysql
# 日志缓存大小
binlog_cache_size= 128K
# 允许下端接入slave
# 当Slave从Master数据库读取日志时更新写入日志中,如果只启动log-bin而没有启动log-slave-updates,则Slave只记录针对自己数据库操作的更新
log-slave-updates = 1
# 避免启动后还是使用老的复制协议
skip_slave_start = 1
# 设定二进制日志的过期天数
expire_logs_days = 6
# 中继日志的名称
relay_log = /data/binlogs/master-relay
# 中继日志索引的名称
relay_log_index = /data/binlogs/master-relay.index
###############################################################################################
# 重启mysql
service mysqld restart
# 登录mysql
mysql -u root -p
###############################################################################################
# 主服务器配置
###############################################################################################
#在Master的数据库中建立一个备份帐户<授予REPLICATION SLAVE权限>
#GRANT REPLICATION SLAVE, RELOAD, SUPER ON *.* TO slave@'192.168.8.%' IDENTIFIED BY 'g+DI?a.#j65=';
#查看master的状态
#SHOW MASTER STATUS;