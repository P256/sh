!/usr/bin/bash
clear
#source ../res.sh
######################################################################################################
echo "1.检查系统是否安装mariadb"
rpm -qa | grep mariadb*
yum -y remove mariadb*
######################################################################################################
echo "2.设置mysql目录"
# 设置mysql目录
mysqlData=/data/mysql
mysqlLog=/data/log/mysql
mysqlPath=/usr/local/mysql
mysqlEtc=$mysqlPath/etc
mysqlTmp=/tmp
# 创建mysql目录
mkdir $mysqlPath $mysqlData $mysqlLog $mysqlEtc
# 设置mysql用户
mysqlUser=mysql
mysqlGroup=mysql
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
echo "3.2安装依赖包readline库,ssl库支持,zib库支持,编程库"
# 安装依赖包 <依赖包：readline库,ssl库支持,zib库支持,编程库,分析器生成器>
#readline-devel zlib-devel openssl-devel 
yum -y install ncurses-devel bison bison-devel
######################################################################################################
# 源码编译方式安装（必需支持boost库）
# 注：官方不带boost的二进制包,需单独去下载安装,必须是1.59版本的新版本不支持,下载后解压放在-DWITH_BOOST指定目录下
#
# 官方下载路径：
# http://www.boost.org/users/download/
# http://101.44.1.123/files/2235000003E38FBF/jaist.dl.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.gz 地址快
# https://nchc.dl.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.gz
#
echo "4.1下载Boost"
curl -O http://101.44.1.123/files/2235000003E38FBF/jaist.dl.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.gz
#
tar zxf boost_1_59_0.tar.gz
# 官方下载路径：
# http://cdn.mysql.com//Downloads/MySQL-5.7/mysql-5.7.17.tar.gz
# http://cdn.mysql.com//Downloads/MySQL-5.7/mysql-boost-5.7.17.tar.gz
# https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-boost-5.7.22.tar.gz
# To CDN 
# http://120.52.72.23/cdn.mysql.com/c3pr90ntc0td//Downloads/MySQL-5.7/mysql-5.7.17.tar.gz
# http://120.52.72.23/cdn.mysql.com/c3pr90ntc0td//Downloads/MySQL-5.7/mysql-boost-5.7.17.tar.gz
# https://cdn.mysql.com//Downloads/MySQL-5.7/mysql-boost-5.7.22.tar.gz

echo "4.2下载Mysql"
mysqlFile=mysql-5.7.22.tar.gz
mysqlFileDir=mysql-5.7.22
curl -O https://cdn.mysql.com//Downloads/MySQL-5.7/$mysqlFile
echo "5.安装mysql"
tar zxf $mysqlFile
cd $mysqlFileDir
# 编译配置【默认为无boost版本，如有更改路径-DWITH_BOOST=../boost_1_59_0  => DWITH_BOOST=boost 即可】
cmake . \
 -DCMAKE_INSTALL_PREFIX=$mysqlPath \
 -DMYSQL_DATADIR=$mysqlData \
 -DDOWNLOAD_BOOST=1 \
 -DWITH_BOOST=../boost_1_59_0 \
 -DSYSCONFDIR=$mysqlEtc \
 -DMYSQL_UNIX_ADDR=$mysqlTmp/mysql.sock \
 -DWITH_INNOBASE_STORAGE_ENGINE=1 \
 -DWITH_PARTITION_STORAGE_ENGINE=1 \
 -DWITH_FEDERATED_STORAGE_ENGINE=1 \
 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
 -DWITH_ARCHIVE_STPRAGE_ENGINE=1 \
 -DWITH_MYISAM_STORAGE_ENGINE=1 \
 -DWITH_ARCHIVE_STORAGE_ENGINE=1 \
 -DENABLED_LOCAL_INFILE=1 \
 -DENABLE_DTRACE=0 \
 -DDEFAULT_CHARSET=utf8 \
 -DDEFAULT_COLLATION=utf8_general_ci \
 -DWITH_EMBEDDED_SERVER=1
# 没有-DWITH_LOBWRAP=0 \
# 手动配置-【无boost】
#cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/data/mysql -DDOWNLOAD_BOOST=1 -DWITH_BOOST=../boost_1_59_0 -DSYSCONFDIR=/etc/mysql -DMYSQL_UNIX_ADDR=/tmp/mysql/mysql.sock -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DENABLED_LOCAL_INFILE=1 -DENABLE_DTRACE=0 -DDEFAULT_CHARSET=utf8mb4 -DDEFAULT_COLLATION=utf8mb4_general_ci -DWITH_EMBEDDED_SERVER=1
# 手动配置-【有boost】
#cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/data/mysql -DDOWNLOAD_BOOST=1 -DWITH_BOOST=boost -DSYSCONFDIR=/etc/mysql -DMYSQL_UNIX_ADDR=/tmp/mysql/mysql.sock -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DENABLED_LOCAL_INFILE=1 -DENABLE_DTRACE=0 -DDEFAULT_CHARSET=utf8mb4 -DDEFAULT_COLLATION=utf8mb4_general_ci -DWITH_EMBEDDED_SERVER=1
#
# 编译配置说明
#-DCMAKE_INSTALL_PREFIX= 				指向mysql安装目录
#-DINSTALL_SBINDIR=sbin 				指向可执行文件目录（prefix/sbin）
#-DMYSQL_DATADIR=/var/lib/mysql 		指向mysql数据文件目录（/var/lib/mysql）
#-DSYSCONFDIR=/etc/mysql 				指向mysql配置文件目录（/etc/mysql）
#
# 相关存储引擎支持					(csv,myisam,myisammrg,heap,innobase,archive,blackhole)
# 启用某个引擎的支持 				(-DWITH_<ENGINE>_STORAGE_ENGINE=1)
#-DWITH_INNOBASE_STORAGE_ENGINE=1
#-DWITH_ARCHIVE_STORAGE_ENGINE=1
#-DWITH_BLACKHOLE_STORAGE_ENGINE=1
#-DWITH_EXAMPLE_STORAGE_ENGINE=1
#-DWITH_FEDERATED_STORAGE_ENGINE=1
#-DWITH_PARTITION_STORAGE_ENGINE=1
# 禁用某个引擎的支持				(-DWITHOUT_<ENGINE>_STORAGE_ENGINE=1)
#-DWITHOUT_EXAMPLE_STORAGE_ENGINE=1
#
# 相关库支持
#-DMYSQL_TCP_PORT=3306 				指定TCP端口为3306
#-DMYSQL_UNIX_ADDR=/tmp/mysqld.sock 指定mysql.sock路径
#-DENABLED_LOCAL_INFILE=1 			启用本地数据导入支持
#-DEXTRA_CHARSETS=all 				启用额外的字符集类型（默认为all）
#-DDEFAULT_CHARSET=utf8 			指定默认的字符集为utf8
#-DDEFAULT_COLLATION=utf8_general_ci设定默认排序规则（utf8_general_ci快速/utf8_unicode_ci准确）
#-DWITH_EMBEDDED_SERVER=1 			编译嵌入式服务器支持
#-DMYSQL_USER=mysql 				指定mysql用户(默认为mysql)
#-DWITH_DEBUG=0 					禁用debug（默认为禁用）
#-DENABLE_PROFILING=0 				禁用Profiling分析（默认为开启）
#-DWITH_COMMENT='string' 			编译环境的描述性注释
#
make
make install
cd ../
echo "##################################################################"
# 进入目录
cd $mysqlPath
# 更改属主属组
chown -R $mysqlUser:$mysqlGroup *
echo "6.提供脚本|二进制文件|库文件|头文件|man手册"
# 1.提供脚本
cp support-files/mysql.server /etc/rc.d/init.d/mysqld
# 赋予执行权限
chmod +x /etc/rc.d/init.d/mysqld
# 添加mysqld为系统服务
chkconfig --add mysqld
# 添加为开机启动
chkconfig mysqld on
# 2.提供二进制文件
echo "export PATH=$mysqlPath/bin:$PATH" > /etc/profile.d/mysql.sh
# 3.提供库文件
echo "$mysqlPath/lib" > /etc/ld.so.conf.d/mysql.conf
# 4.提供头文件
ln -sv $mysqlPath/include /usr/include/mysql
# 5.提供man手册  
#echo "MANPATH $mysqlPath" >> /etc/man.config
# 让man手册立刻生效为最新
#man -M $mysqlPath/man mysqld
# 生效配置文件
source /etc/profile
#
echo "7.手动配置文件"
# 手动配置文件
vi $mysqlEtc/my.cnf
# 配置文件
#[Client]
#port = 3306
#[mysqld]
#设置3306端口
#port = 3306
# 设置mysql的安装目录
#basedir=/usr/local/mysql
# 设置mysql数据库的数据的存放目录
#datadir=/data/mysql
# 允许最大连接数
#max_connections=200
# 服务端使用的字符集默认为8比特编码的latin1字符集
#character-set-server=utf8
# 创建新表时将使用的默认存储引擎
#default-storage-engine=INNODB
# socket
#socket=/tmp/mysql.sock
# 日志
#log-error=/var/log/mysqld.log
# 进程
#pid-file=/var/run/mysqld/mysqld.pid
#[mysql]
# 设置mysql客户端默认字符集
#default-character-set=utf8

#
echo "8.初始化数据库"
# 初始化库文件
# 参数说明：
#	--initialize	生成随机密码
#	--initialize-insecure 生成空密码
#	--innodb_undo_tablespaces=3	[可选]设定创建的undo表空间的个数
bin/mysqld --initialize-insecure --basedir=$mysqlPath --datadir=$mysqlData --user=$mysqlUser
# bin/mysqld --initialize-insecure --basedir=/usr/local/mysql --datadir=/data/mysql --pid-file=/tmp/mysql.pid --user=mysql
#
echo "9.启动服务,连接Mysql服务器"
# 启动服务
service mysqld start
#
echo "10.防火墙开启3306端口"
#
# 防火墙开启3306端口
# 命令含义
# --zone #作用域 
# --add-port=3306/tcp  #添加端口，格式为：端口/通讯协议
# --permanent   #永久生效，没有此参数重启后失效
firewall-cmd --zone=public --add-port=3306/tcp --permanent
# 重启防火墙
firewall-cmd --reload
#
# 可选初始化
#bin/mysql_secure_installation
#
# 登录mysql
#mysql -u root -p
# 增加adnin管理员账号
#mysql> GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'admin101' WITH GRANT OPTION;
# 刷新权限
#mysql> FLUSH PRIVILEGES;
