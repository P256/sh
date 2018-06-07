!/usr/bin/bash
clear
source res.sh
######################################################################################################
echo "1.检查系统是否安装mariadb"
rpm -qa | grep mariadb*
yum -y remove mariadb*
######################################################################################################
echo "2.设置mysql目录"
# 设置mysql目录
mysqlData=/data/mariadb
mysqlLog=/data/log/mariadb
mysqlPath=/usr/local/mariadb
mysqlEtc=$mysqlPath/etc
mysqlTmp=/tmp
# 创建mysql目录
mkdir $mysqlPath $mysqlData $mysqlEtc $mysqlLog
# 设置mysql用户
mysqlUser=mariadb
mysqlGroup=mariadb
# 创建用户(组)赋予家目录
groupadd -r $mysqlUser
useradd -g $mysqlUser -r -s /sbin/nologin -M -d $mysqlData $mysqlGroup
# 赋予web权限
chown -R $mysqlUser:$mysqlGroup $mysqlData $mysqlPath $mysqlEtc $mysqlLog
######################################################################################################
echo "3.进入src目录下载安装"
cd /usr/local/src/
echo "3.1安装cmake依赖包"
# 3.1yum安装<依赖libarchive>
yum -y install cmake
echo "3.2安装依赖包readline库,ssl库支持,zib库支持,编程库"
# 安装依赖包 <依赖包：readline库,ssl库支持,zib库支持,编程库>
yum -y install readline-devel zlib-devel openssl-devel ncurses-devel
######################################################################################################
echo "4.下载 mariadb"
# https://mirrors.tuna.tsinghua.edu.cn/mariadb//mariadb-5.5.53/source/mariadb-5.5.53.tar.gz
# https://mirrors.tuna.tsinghua.edu.cn/mariadb//mariadb-5.5.54/source/mariadb-5.5.54.tar.gz
# https://mirrors.tuna.tsinghua.edu.cn/mariadb//mariadb-10.1.22/source/mariadb-10.1.22.tar.gz
mariadb=mariadb-10.1.22
curl -O https://mirrors.tuna.tsinghua.edu.cn/mariadb//${mariadb}/source/${mariadb}.tar.gz
echo "5.安装mariadb"
tar zxf $mariadb.tar.gz
cd $mariadb
# 编译配置 [-DMYSQL_TCP_PORT=3306 ]
cmake . -DCMAKE_INSTALL_PREFIX=$mysqlPath -DMYSQL_DATADIR=$mysqlData -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STPRAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWIYH_READLINE=1 -DWIYH_SSL=system -DVITH_ZLIB=system -DWITH_LOBWRAP=0 -DSYSCONFDIR=$mysqlEtc -DMYSQL_TCP_PORT=8306 -DMYSQL_UNIX_ADDR=$mysqlTmp/mysql.sock -DENABLED_LOCAL_INFILE=1 -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci
# 手动编译
#cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mariadb -DMYSQL_DATADIR=/data/mariadb -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STPRAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_EXAMPLE_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DWIYH_READLINE=1 -DWIYH_SSL=system -DVITH_ZLIB=system -DWITH_LOBWRAP=0 -DSYSCONFDIR=/etc/mariadb -DMYSQL_TCP_PORT=8306 -DMYSQL_UNIX_ADDR=/tmp/mariadb/mysql.sock -DENABLED_LOCAL_INFILE=1 -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci
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
#-DWITH_READLINE=1 					启用readline库支持（提供可编辑的命令行）
#-DWITH_SSL=system 					启用ssl库支持（安全套接层）
#-DWITH_ZLIB=system 				启用libz库支持（zib、gzib相关）
#-DWTIH_LIBWRAP=0 					禁用libwrap库（实现了通用TCP包装的功能，为网络服务守护进程使用）
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
echo "6.准备MariaDB脚本|配置文件"
cd $mysqlPath
echo "6.1初始化数据库"
# 更改属主属组
chown -R $mysqlUser:$mysqlGroup *
# 初始化库文件
scripts/mysql_install_db --basedir=$mysqlPath --datadir=$mysqlData --user=$mysqlUser --skip-name-resolve
echo "6.2提供脚本"
# 提供脚本
cp support-files/mysql.server /etc/rc.d/init.d/mysqld
# 赋予执行权限
chmod +x /etc/rc.d/init.d/mysqld
# 添加mysqld为系统服务
chkconfig --add mysqld
# 添加为开机启动
chkconfig mysqld on
echo "6.3提供配置文件"
cp support-files/my-large.cnf /etc/my.cnf
# 修改/etc/selinux/config文件中设置SELINUX=disabled,然后重启或等待下次重启
vi /etc/my.cnf
# 编辑配置文件[mysqld]段填写如下内容
#[mysqld]
# 数据目录
#datadir = /data/mysql
# 设置线程数=核心数x2
#thread_concurrency = 8
echo "7.提供二进制文件|库文件|头文件|man手册"
# 提供二进制文件
echo "export PATH=$mysqlPath/bin:$PATH" > /etc/profile.d/mysql.sh
# 提供库文件
echo "$mysqlPath/lib" > /etc/ld.so.conf.d/mysql.conf
# 提供头文件  
ln -sv /usr/local/include /usr/include/mysql
# 提供man手册  
echo "MANPATH $mysqlPath" >> /etc/man.config
# 让man手册立刻生效为最新
#man -M $mysqlPath/man mysqld
echo "8.启动服务,连接MariaDB服务器"
# 启动服务
service mysqld start
$mysqlPath/bin/mysql_secure_installation
#
# 登录mysql
#mysql -u root -p
# 增加adnin管理员账号
#GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'admin101' WITH GRANT OPTION;
# 刷新权限
#FLUSH PRIVILEGES;

#
# 防火墙开启3306端口
# 命令含义
# --zone #作用域 
# --add-port=3306/tcp  #添加端口，格式为：端口/通讯协议
# --permanent   #永久生效，没有此参数重启后失效
firewall-cmd --zone=public --add-port=3306/tcp --permanent

# 重启防火墙
firewall-cmd --reload