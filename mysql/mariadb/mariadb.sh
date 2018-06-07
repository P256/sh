#!/usr/bin/bash
clear
rpm -qa | wc -l
rpm -qa | sort
clear
echo "0.检查当前系统mariadb"
rpm -qa | grep mariadb*
yum remove mariadb*
#设置安装路径
prefix=/usr/local/mysql
data=/data/mysql
version=5.5.53
echo "1.创建数据目录"
mkdir /data
mkdir /data/mysql
echo "##################################################################"
echo "2.新建用户以安全方式运行进程"
#创建mysql组
groupadd -r mysql
#创建mysql用户
useradd -g mysql -r -s /sbin/nologin -M -d /data/mysql mysql
#更改数据目录的属主属组
chown mysql:mysql /data/mysql
echo "##################################################################"
echo "3.进入src目录下载安装"
cd /usr/local/src/
echo "Install cmake"
#3.1yum安装<依赖libarchive>
yum -y install cmake
echo "INstall dependent package"
#安装特定的开发包(防止编译时出错) gcc-c++<依赖libstdc++-devel>
yum -y install readline-devel zlib-devel openssl-devel ncurses-devel gcc gcc-c++
echo "##################################################################"
echo "4.Dowloading mariadb"
curl -O https://mirrors.tuna.tsinghua.edu.cn/mariadb//mariadb-${version}/source/mariadb-${version}.tar.gz
echo "5.Install mariadb"
tar zxf mariadb-${version}.tar.gz
cd mariadb-${version}
cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/data/mysql/ -DSYSCONFDIR=/usr/local/mysql/etc -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STPRAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWIYH_READLINE=1 -DWIYH_SSL=system -DVITH_ZLIB=system -DWITH_LOBWRAP=0 -DMYSQL_UNIX_ADDR=/usr/local/mysql/tmp/mysql.sock -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci
make
make install
cd ../
echo "##################################################################"
echo "6.准备MariaDB脚本|配置文件"
cd /usr/local/mysql
mkdir etc tmp
echo "6.1初始化数据库"
#更改属主属组
chown -R mysql:mysql *
#初始化库文件
scripts/mysql_install_db --basedir=/usr/local/mysql --datadir=/data/mysql --user=mysql --skip-name-resolve
echo "6.2提供脚本"
#提供脚本
cp support-files/mysql.server /etc/rc.d/init.d/mysqld
#赋予执行权限
chmod +x /etc/rc.d/init.d/mysqld
#添加mysqld为系统服务
chkconfig --add mysqld
#添加为开机启动
chkconfig mysqld on
echo "6.3提供配置文件"
cp support-files/my-large.cnf etc/my.cnf
#修改/etc/selinux/config文件中设置SELINUX=disabled,然后重启或等待下次重启
vi etc/my.cnf
#编辑配置文件[mysqld]段填写如下内容
#[mysqld]
#数据目录
#datadir = /data/mysql
#设置线程数=核心数x2
#thread_concurrency = 8
echo "7.提供二进制文件|库文件|头文件|man手册"
#提供二进制文件
echo 'export PATH=/usr/local/mysql/bin:$PATH' > /etc/profile.d/mysql.sh
#提供库文件
echo '/usr/local/mysql/lib' > /etc/ld.so.conf.d/mysql.conf
#提供头文件  
ln -sv /usr/local/include /usr/include/mysql
#提供man手册  
echo 'MANPATH /usr/local/mysql' >> /etc/man.config
#让man手册立刻生效为最新
#man -M /usr/local/mysql/man mysqld
echo "8.启动服务,连接MariaDB服务器"
#启动服务
service mysqld start
ss -ntl | grep :3306
/usr/local/mysql/bin/mysql_secure_installation
# 登录mysql
mysql -u root -p
# 增加adnin管理员账号
#GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'admin101' WITH GRANT OPTION;
# 刷新权限
#FLUSH PRIVILEGES;
