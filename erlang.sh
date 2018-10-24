# 1.安装erlang

# 1.利用yum安装erlang编译所依赖的环境 
yum install make gcc gcc-c++ kernel-devel m4ncurses-devel openssl-devel unixODBC-devel

# 2.下载erlang 进行源码安装 
# erlang官网地址： http://www.erlang.org/downloads
curl -O http://erlang.org/download/otp_src_21.1.tar.gz

#解压
tar -xvf otp_src_21.1.tar.gz
#进入目录
cd cd otp_src_21.1
#编译
./configure  --prefix=/usr/local/erlang --without-javac
#安装
make && make install
#
erl version
