!/usr/bin/bash
clear
#source res.sh
######################################################################################################
echo "1.检查系统是否安装mariadb"
rpm -qa | grep mariadb*
yum -y remove mariadb*
######################################################################################################
echo "2.设置percona目录"
# 设置mysql目录
mysqlData=/data/percona
mysqlLog=/data/log/percona
mysqlPath=/usr/local/percona
mysqlEtc=$mysqlPath/etc
mysqlTmp=/tmp
# 创建mysql目录
mkdir $mysqlPath $mysqlData $mysqlLog $mysqlEtc
# 设置mysql用户
mysqlUser=percona
mysqlGroup=percona
# 创建用户(组)赋予家目录
groupadd -r $mysqlUser
useradd -g $mysqlUser -r -s /sbin/nologin -M -d $mysqlData $mysqlGroup
# 赋予权限
chown -R $mysqlUser:$mysqlGroup $mysqlData $mysqlPath $mysqlLog $mysqlEtc
######################################################################################################
echo "3.进入src目录下载安装"
cd /usr/local/src/
echo "3.1安装cmake依赖包"
# https://cmake.org/files/v3.7/cmake-3.7.2.tar.gz
# 3.1yum安装<依赖libarchive>
yum -y install cmake
echo "3.2安装依赖包"
# 安装依赖包
# 可选：readline-devel openssl-devel bison bison-devel per
yum -y install ncurses-devel zlib-devel
##################################################################################################################
# 源码编译方式安装（必需支持boost库）
# 注：官方不带boost的二进制包,需单独去下载安装,必须是1.59版本的新版本不支持,下载后解压放在-DWITH_BOOST指定目录下
##################################################################################################################
# 官方下载路径：
# http://www.boost.org/users/download/
# http://101.44.1.123/files/2235000003E38FBF/jaist.dl.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.gz 地址快
# https://nchc.dl.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.gz
#
echo "4.1下载Boost"
curl -O http://101.44.1.123/files/2235000003E38FBF/jaist.dl.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.gz
#
tar zxf boost_1_59_0.tar.gz
#
# 下载地址
# https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-5.7.17-12/source/tarball/percona-server-5.7.17-12.tar.gz
echo "4.2下载Percona"
mysql=percona-server-5.7.17-12
curl -O https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-5.7.17-12/source/tarball/percona-server-5.7.17-12.tar.gz
echo "5.安装Percona"
tar zxf $mysql.tar.gz
cd $mysql
# 编译配置
cmake -DCMAKE_INSTALL_PREFIX=$mysqlPath \
-DMYSQL_UNIX_ADDR=$mysqlTmp/percona.sock \
-DWITH_BOOST=../boost_1_59_0 \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_ARCHIVE_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITH_EDITLINE=bundled \
-DENABLED_LOCAL_INFILE=1 \
-DMYSQL_DATADIR=$mysqlData \
-DMYSQL_TCP_PORT=9306 \
-DZLIB_INCLUDE_DIR:PATH=/usr/include \
-DENABLE_DOWNLOADS=1
# 手动配置
#cmake -DCMAKE_INSTALL_PREFIX=/usr/local/percona -DMYSQL_UNIX_ADDR=/tmp/percona.sock -DWITH_BOOST=../boost_1_59_0 -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_EDITLINE=bundled -DENABLED_LOCAL_INFILE=1 -DMYSQL_DATADIR=/data/percona -DMYSQL_TCP_PORT=9306 -DZLIB_INCLUDE_DIR:PATH=/usr/include -DENABLE_DOWNLOADS=1
make
make install
cd ../
echo "##################################################################"
echo "6.准备percona脚本|配置文件"
cd $mysqlPath
echo "6.1初始化数据库"
# 更改属主属组
chown -R $mysqlUser:$mysqlGroup *
# 初始化库文件
# 参数说明：
#	--initialize	生成随机密码
#	--initialize-insecure 生成空密码
#	--innodb_undo_tablespaces=3	[可选]设定创建的undo表空间的个数
bin/mysqld --initialize-insecure --basedir=$mysqlPath --datadir=$mysqlData --user=$mysqlUser
# bin/mysqld --initialize-insecure --basedir=/usr/local/percona --datadir=/data/percona --user=percona
echo "6.2提供脚本"
# 提供脚本
cp support-files/mysql.server /etc/rc.d/init.d/percona
# 赋予执行权限
chmod +x /etc/rc.d/init.d/percona
# 添加mysqld为系统服务
chkconfig --add percona
# 添加为开机启动
chkconfig percona on
echo "6.3提供配置文件"
cp support-files/my-default.cnf $mysqlEtc/my.cnf
# 
vi $mysqlEtc/my.cnf
# 配置文件
#[mysqld]
# 安装目录
#basedir = /usr/local/percona
# 数据目录
#datadir = /data/percona
#
# [可选]
# 服务编号
#server_id = 1
# 端口号
#port = 3306
# 配置socket文件
#socket=/tmp/percona.sock
# 配置错误日志文件
#log-error=/data/percona/error.log
# 进程ID
#pid-file=/data/percona/local.pid
# 设置线程数=核心数x2
#thread_concurrency = 8
# 开启慢查询
#slow_query_log=on
# 配置sql慢查询的时间,这里是2秒
#long_query_time = 2
# 记录查询较慢的语句
#slow_query_log_file= slow.query.log
# 记录没有使用索引的语句
#log-queries-not-using-indexes = no.index.log
# 记录所有执行的语句文件
#log=all.log
# 二进制日志的名称
#log-bin = master-bin
# 二进制日志索引的名称
#log_bin_index = master-bin.index
# 中继日志的名称
#relay_log = master-relay
# 中继日志索引的名称
#relay_log_index = master-relay.index

echo "7.提供二进制文件|库文件|头文件|man手册"
# 提供二进制文件 
echo "export PATH=$mysqlPath/bin:$PATH" > /etc/profile.d/percona.sh
# 提供库文件
echo "$mysqlPath/lib" > /etc/ld.so.conf.d/percona.conf
# 提供头文件  
ln -sv /usr/local/include /usr/include/percona
# 提供man手册  
echo "MANPATH $mysqlPath" >> /etc/man.config
# 让man手册立刻生效为最新
#man -M $mysqlPath/man mysqld
echo "8.启动服务,连接Percona服务器"
# 启动服务
service percona start
#$mysqlPath/bin/mysql_secure_installation
#
# 登录mysql
#mysql -u root -p
# 增加adnin管理员账号
#GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'admin101' WITH GRANT OPTION;
# 刷新权限
#FLUSH PRIVILEGES;

#
# 防火墙开启9306端口
# 命令含义
# --zone #作用域 
# --add-port=9306/tcp  #添加端口，格式为：端口/通讯协议
# --permanent   #永久生效，没有此参数重启后失效
firewall-cmd --zone=public --add-port=9306/tcp --permanent

# 重启防火墙
firewall-cmd --reload