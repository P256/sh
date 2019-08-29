# 1.安装erlang

# erlang编译所依赖的环境 
yum install make gcc gcc-c++ kernel-devel m4ncurses-devel openssl-devel unixODBC-devel

# 下载erlang 进行源码安装 
#erlang官网地址： http://www.erlang.org/downloads
curl -O http://erlang.org/download/otp_src_21.1.tar.gz

# 解压并进行编译安装
#解压
tar -xvf otp_src_21.1.tar.gz
#进入目录
cd cd otp_src_21.1
#编译
./configure  --prefix=/usr/local/erlang --without-javac
#安装
make && make install
#
# 环境变量配置
vi /etc/profile
#	export PATH=$PATH:/usr/local/erlang/bin
source /etc/profile

# 2. 安装rabbitmq
#
#rabbitmq官网下载地址 ： http://www.rabbitmq.com/download.html 
#rabbitmq源码下载地址： http://www.rabbitmq.com/install-generic-unix.html 
#
curl -O https://dl.bintray.com/rabbitmq/all/rabbitmq-server/3.7.8/rabbitmq-server-generic-unix-3.7.8.tar.xz
# 解压
tar -xvf rabbitmq-server-generic-unix-3.7.8.tar.xz
# 
mv rabbitmq_server-3.7.8/ ../rabbitmq
# 环境变量配置
vi /etc/profile
#	export PATH=$PATH:/usr/local/erlang/bin:/usr/local/rabbitmq/sbin
source /etc/profile
# 命令
#启动服务：rabbitmq-server -detached
#查看状态：rabbitmqctl status
#关闭服务：rabbitmqctl stop
#列出角色：rabbitmqctl list_users

# 启用插件：
rabbitmq-plugins enable rabbitmq_management

# 添加用户，后面两个参数分别是用户名和密码
rabbitmqctl add_user admin admin
# 添加权限
rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
# 修改角色
rabbitmqctl set_user_tags admin administrator

# 参考
#https://blog.csdn.net/yin767833376/article/details/81223491?utm_source=blogxgwz13