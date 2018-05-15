# MHA Manager 端配置文件
mkdir /usr/local/masterha /usr/local/masterha/app1 /data/binlogs
# MHA目录
cd /usr/local/masterha
# 复制配置文件/脚本文件
cp -r /usr/local/src/mha4mysql-manager/samples/* ./
# 授权脚本执行权限
chmod +x scripts/*
# 配置文件
mv conf/masterha_default.cnf /etc/masterha_default.cnf

######################################################################
# 全局配置文件
vi /etc/masterha_default.cnf
[server default]
# 这下面的都是全局配置,适用于所有app.cnf
user=manage
password=manage101
ssh_user=root
master_binlog_dir=/data/binlogs
remote_workdir=/data/binlogs
secondary_check_script=masterha_secondary_check -s 192.168.8.11 -s 192.168.8.12 -s 192.168.8.13 --user=root --master_host=192.168.8.11 --master_ip=192.168.8.11 --master_port=3306
ping_interval=3
master_ip_failover_script=/usr/local/masterha/scripts/master_ip_failover
shutdown_script=/usr/local/masterha/scripts/power_manager
report_script=/usr/local/masterha/scripts/send_master_failover_mail
#master_ip_online_change_script=/usr/local/masterha/scripts/master_ip_online_change
#
# 应用配置文件
vi conf/app1.cnf
[server default]
manager_workdir=/usr/local/masterha/app1
manager_log=/usr/local/masterha/app1/app1.log
check_repl_delay=0

[server1]
hostname=192.168.8.11
candidate_master=1

[server2]
hostname=192.168.8.12
candidate_master=1

[server3]
hostname=192.168.8.13
no_master=1




