#
# 参考文献：http://blog.csdn.net/lichangzai/article/details/50470771
#
# 本例中manager节点和node节点ip
manager：192.168.8.10
node1：	 192.168.8.11
node2：	 192.168.8.12
node3：	 192.168.8.13

######################################################################################################
# hosts 配置
vi /etc/hosts
192.168.8.10 monitor
192.168.8.11 master
192.168.8.12 slave01 候选master
192.168.8.13 slave02

######################################################################################################
# Slave配置参数
log-bin = MySQL-bin
log-bin-index = mysql-bin.index
read_only=1 
relay_log_purge=0  #（一主一丛不需要此项，两从及以上建议开次参数，防止切换为成主库的从库自动删除中继日志后，无法给其他从库应用这部分日志）

######################################################################################################
# 配置主从同步 <略>

######################################################################################################
# MHA Manager 端配置
######################################################################################################
# 安装perl依赖包
yum -y install perl-DBD-MySQL perl-Config-Tiny
# 安装epel源安装依赖包
rpm -ivh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# 安装依赖包一
yum -y install perl-Log-Dispatch perl-Parallel-ForkManager
# 安装依赖包二
yum -y install perl-ExtUtils-MakeMaker perl-CPAN
######################################################################################################
#
cd /usr/local/src/mha4mysql-manager
#
perl Makefile.PL
#
make
make install
#
cp samples/scripts/* /usr/local/bin/
#
chmod +x master_ip_failover master_ip_online_change power_manager send_report 
#
cd ../
#
#masterha_check_ssh              检查MHA的SSH配置状况
#masterha_check_repl             检查MySQL复制状况
#masterha_manger                 启动MHA
#masterha_check_status           检测当前MHA运行状态
#masterha_master_monitor         检测master是否宕机
#masterha_master_switch          控制故障转移（自动或者手动）
#masterha_conf_host              添加或删除配置的server信息
#
#master_ip_failover              自动切换时vip管理的脚本,如果我们使用keepalived的,我们可以自己编写脚本完成对vip的管理
#								 比如监控mysql,如果mysql异常,我们停止keepalived就行,这样vip就会自动漂移.
#master_ip_online_change         在线切换时vip的管理,不是必须,同样可以可以自行编写简单的shell完成
#power_manager                   故障发生后关闭主机的脚本,不是必须
#send_report                     因故障切换后发送报警的脚本,不是必须,可自行编写简单的shell完成
######################################################################################################

# MHA Manager 端配置文件
mkdir /usr/local/masterha
#
cp /usr/local/src/mha4mysql-manager/samples/conf/app1.cnf /usr/local/masterha/
#
vi /usr/local/masterha/app1.cnf
########################################################################################################
[server default]
# 设置manager的工作目录
manager_workdir=/usr/local/masterha/app1
remote_workdir=/usr/local/masterha/app1
# 设置manager的日志
manager_log=/usr/local/masterha/app1/manager.log
# 设置监控用户/密码
# GRANT SUPER,RELOAD,SELECT ON *.* TO 'manage'@'192.168.8.%' IDENTIFIED BY 'manage101' WITH GRANT OPTION;
user=root
password=root101
# 设置ssh登录的用户
ssh_user=root
ssh_port=22
# 设置复制用户/密码
repl_user=slave
repl_password=g+DI?a.#j65mu
# 链式复制<A-B-C>
multi_tier_slave=1
# 设置监控主库,发送ping包的时间间隔,默认是3秒,尝试三次没有回应的时候自动进行railover
ping_interval=1
ping_type=CONNECT
# 设置自动failover时候的切换脚本
master_ip_failover_script=/usr/local/bin/master_ip_failover
# 设置手动切换时候的切换脚本
master_ip_online_change_script=/usr/local/bin/master_ip_online_change
# 防止网络抖动误切换,造成数据不一致
secondary_check_script=/usr/local/bin/masterha_secondary_check -s 192.168.8.10 -s 192.168.8.12 --user=root --master_host=master --master_ip=192.168.8.11 --master_port=3306
# 设置发生切换后发送的报警的脚本
report_script=/usr/local/send_report
# 设置故障发生后关闭故障主机脚本（该脚本的主要作用是关闭主机放在发生脑裂,这里没有使用）   
shutdown_script=""

[server1]
hostname=192.168.8.11
port=3306
ssh_port=22
master_binlog_dir=/data/binlogs

[server2]
hostname=192.168.8.12
port=3306
ssh_port=22
master_binlog_dir=/data/binlogs

# 设置为候选master,如果设置该参数以后,发生主从切换以后将会将此从库提升为主库,即使这个主库不是集群中事件最新的slave
candidate_master=1
# 默认情况下如果一个slave落后master 100M的relay logs的话,MHA将不会选择该slave作为一个新的master,
# 因为对于这个slave的恢复需要花费很长时间,通过设置check_repl_delay=0,MHA触发切换在选择一个新的master的时候将会忽略复制延时,
# 这个参数对于设置了candidate_master=1的主机非常有用，因为这个候选主在切换的过程中一定是新的master
check_repl_delay=1

[server3]
hostname=192.168.8.13
port=3306
ssh_port=22
master_binlog_dir=/data/binlogs

########################################################################################################

# 配置SSH无密码登录 <master,slave分别均安装>
ssh-keygen -P ''
ssh-copy-id -p 22 root@192.168.8.11
ssh-copy-id -p 22 root@192.168.8.12
ssh-copy-id -p 22 root@192.168.8.13
ssh-copy-id -p 22 root@192.168.8.14

# 检查SSH配置 <检查MHA Manger到所有MHA Node的SSH连接状态>
masterha_check_ssh --conf=/usr/local/masterha/app1.cnf

# 检查整个复制环境状况 <通过masterha_check_repl脚本查看整个集群的状态>
masterha_check_repl --conf=/usr/local/masterha/app1.cnf

# 检查MHA Manager的状态 <通过master_check_status脚本查看Manager的状态>
masterha_check_status --conf=/usr/local/masterha/app1.cnf

# 开启MHA Manager监控


# Ques：http://blog.csdn.net/zengxuewen2045/article/details/51524880

# Ques：http://suifu.blog.51cto.com/9167728/1869520

######################################################################################################
# MHA Node 端配置
######################################################################################################

yum install perl-DBD-MySQL

#
#save_binary_logs                保存和复制master的二进制日志
#apply_diff_relay_logs           识别差异的中继日志事件并将其差异的事件应用于其他的slave
#filter_mysqlbinlog              去除不必要的ROLLBACK事件（MHA已不再使用这个工具）
#purge_relay_logs                清除中继日志（不会阻塞SQL线程）

