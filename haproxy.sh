echo "============================安装Haproxy开始=============================="
tar zxvf haproxy-1.5.14.tar.gz
cd haproxy-1.5.14
make TARGET=linux26 PREFIX=/usr/local/haproxy
make install PREFIX=/usr/local/haproxy
groupadd haproxy
useradd -g haproxy haproxy
haproxy -f /usr/local/haproxy/haproxy.cfg
cd ../
echo "============================安装Haproxy完成=============================="