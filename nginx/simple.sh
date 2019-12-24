!/usr/bin/bash
clear

# http://zlib.net/zlib-1.2.11.tar.gz
# https://www.openssl.org/source/openssl-1.1.0e.tar.gz
# http://nchc.dl.sourceforge.net/project/pcre/pcre/8.40/pcre-8.40.tar.gz
# 下载并安装依赖包 <zlib,openssl,pcre>
# 设置版本号
zlib=zlib-1.2.11
openssl=openssl-1.1.0f
pcre=pcre-8.40
curl -O http://zlib.net/${zlib}.tar.gz
curl -O https://www.openssl.org/source/${openssl}.tar.gz
curl -O http://nchc.dl.sourceforge.net/project/pcre/pcre/8.40/${pcre}.tar.gz
# 解压依赖包
tar -zxf ${zlib}.tar.gz
tar -zxf ${openssl}.tar.gz
tar -zxf ${pcre}.tar.gz
# http://nginx.org/download/nginx-1.12.0.tar.gz
# http://nginx.org/download/nginx-1.12.2.tar.gz
# http://nginx.org/download/nginx-1.14.0.tar.gz
# 下载NG
# 设置版本号
nginx=nginx-1.12.0
curl -O http://nginx.org/download/${nginx}.tar.gz
# 解压NG
tar -zxf $nginx.tar.gz
echo "5.进入nginx目录编译"
cd $nginx
# 查编译配置参数
./configure --help > nginx-configure.txt
#
# [可选]
# --user=$webUser
# --group=$webGroup
# --conf-path=$webEtc/conf/nginx.conf
# --pid-path=$webTmp/nginx.pid
# --lock-path=$webTmp/nginx.lock
# --http-log-path=$webLog/http.log
# --error-log-path=$webLog/error.log
# --with-http_stub_status_module
# --with-openssl=../$openssl
# --with-http_ssl_module
# --with-debug
# --with-stream
# 
#【可选扩展】
# 
# rtmp 流媒体模块（https://codeload.github.com/arut/nginx-rtmp-module/zip/v1.2.1）
# --add-module=../nginx-rtmp-module-1.2.1
# 
# 
# 


./configure --prefix=/usr/local/nginx --user=web --group=web --pid-path=/usr/local/nginx/nginx.pid --lock-path=/usr/local/nginx/nginx.lock --with-pcre=../pcre-8.40 --with-zlib=../zlib-1.2.11 --with-threads --with-http_stub_status_module --with-debug --with-stream --http-client-body-temp-path=/usr/local/nginx/tmp/client/ --http-proxy-temp-path=/usr/local/nginx/tmp/proxy --http-fastcgi-temp-path=/usr/local/nginx/tmp/fastcgi --http-uwsgi-temp-path=/usr/local/nginx/tmp/uwsgi --http-scgi-temp-path=/usr/local/nginx/tmp/scgi


 --http-log-path=/usr/local/nginx/log/http.log --error-log-path=/usr/local/nginx/log/error.log 

 




# 

#
echo "6.开始编译"
make
make install
echo "7.安装完成"
# 配置Nginx
#
# 配置环境变量
sed -i '$a WEB_PATH='${webPath} /etc/profile
sed -i '$a PATH=$PATH:$WEB_PATH/sbin' /etc/profile
sed -i '$a export PATH WEB_PATH' /etc/profile
source /etc/profile

#
# 防火墙开启80端口
# 命令含义
# --zone #作用域 
# --add-port=80/tcp  #添加端口，格式为：端口/通讯协议
# --permanent   #永久生效，没有此参数重启后失效
firewall-cmd --zone=public --add-port=80/tcp --permanent

# 重启防火墙
firewall-cmd --reload
#
#启动： systemctl start firewalld
#查看状态： systemctl status firewalld 
#停止： systemctl disable firewalld
#禁用： systemctl stop firewalld

# 配置service
cat <<EOF > /usr/lib/systemd/system/nginx.service
[Unit]
Description=nginx - high performance web server
Documentation=http://nginx.org/en/docs/
After=network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/var/run/nginx.pid
ExecStartPre=/usr/local/nginx/sbin/nginx -t -c /usr/local/nginx/conf/nginx.conf
ExecStart=/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
EOF
# 开机
systemctl enable nginx
# 启动
systemctl start nginx