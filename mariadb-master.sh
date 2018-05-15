#!/usr/bin/bash
clear
mkdir /data/binlogs
chown -R mysql:mysql /data/binlogs/
vi etc/my.cnf
# 编辑配置文件[mysqld]段填写如下内容
##################################################################################
# Replication Master Server (default)
##################################################################################
# 服务器标志号
# <配置文件中不能出现多个这样的标识,如果出现多个的话mysql以第一个为准,一组主从中此标识号不能重复>
#server-id		= 1
# 开启bin-log,并指定文件目录和文件名前缀
#log-bin		= /data/binlogs/master-bin
# 设置bin-log日志文件格式为:MIXED,可以防止主键重复.
#binlog_format	= mixed
# 每个bin-log最大大小,当此大小等于500M时会自动生成一个新的日志文件.
# 一条记录不会写在2个日志文件中,所以有时日志文件会超过此大小.
#max_binlog_size= 500M
# 需要同步的数据库名字,如果是多个,就以此格式在写一行即可
#binlog-do-db 	= demo
# 不需要同步的数据库名字,如果是多个,就以此格式在写一行即可
#binlog-ignore-db= mysql
# 日志缓存大小
#binlog_cache_size= 128K
# 当Slave从Master数据库读取日志时更新新写入日志中,如果只启动log-bin而没有启动log-slave-updates则Slave只记录针对自己数据库操作的更新
#log-slave-updates
# 设置bin-log日志文件保存的天数,此参数mysql5.0以下版本不支持
#expire_logs_day=30
###################################################################################
# 重启mysql
service mysqld restart
# 登录mysql
mysql -u root -p
###############################################################################################
#主服务器配置<106>
###############################################################################################
#在Master的数据库中建立一个备份帐户<授予REPLICATION SLAVE权限>
#GRANT REPLICATION SLAVE, RELOAD, SUPER ON *.* TO backup@'192.168.1.%' IDENTIFIED BY 'backup';
#查看master的状态
#SHOW MASTER STATUS;


















