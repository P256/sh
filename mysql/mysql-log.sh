#!/usr/bin/bash
clear
vi etc/my.cnf
# 开启慢查询
slow_query_log = on
# 记录查询较慢的语句
slow_query_log_file = /data/log/mysql/slow.query.log
# 配置sql慢查询的时间,这里是2秒
long_query_time = 2
# 开启没有使用索引的语句
log_queries_not_using_indexes = on
# 开启查询日志-(系统开销比较大,一般不建议开启)
general_log = on
# 记录语句
general_log_file = /data/log/mysql/general.log
#


#
#日志种类： 
#错误日志(error log)： log-err
#查询日志(general  query log)： log
#慢查询日志: -log-slow-queries 
#二进制日志 (binary log)： log-bin
#中继日志( relay log)
#innodb 在线redo日志
#默认情况下,没有启动任何log,可以通过log选项来启动相关的log

# 查看日志的种类
#mysql-> SHOW VARIABLES LIKE 'log_%';

# 查看错误日志
#mysql-> SHOW VARIABLES LIKE '%err%';

# 查看日志的存放方式
#mysql-> SHOW VARIABLES LIKE "%log_output%";


