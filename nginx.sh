#!/bin/bash
clear
echo "##################################################################"
echo "检查当前系统"
rpm -qa | grep httpd*
yum remove httpd*
echo "设置资源来源"
sourceUrl="http://192.168.100.83/packet"
src=/usr/local/src
dataDir=/data
dataLog=/data/log
# 设置用户与相关目录
webUser=web
webGroup=web
webPath=/usr/local/nginx
tempPath=/usr/local/nginx/tmp
webData=$dataDir/web
webLog=$dataLog/web
# 创建用户
groupadd -r $webUser
useradd -g $webUser -r -s /sbin/nologin -M -d $webData $webGroup
# 创建data目录
mkdir $dataDir $dataLog
# 创建web目录
mkdir $webPath $webData $webLog $tempPath
# 赋予web权限
chown -R $webUser:$webUser $webData $webPath $webLog
echo "进入nginx目录编译"
cd $src
# 下载
# http://nginx.org/download/nginx-1.10.2.tar.gz
# 编译前先解决依赖包<zlib,openssl,pcre>
version=nginx-1.10.2
curl -O http://nginx.org/download/${version}.tar.gz
curl -O $sourceUrl/zlib-1.2.8.tar.gz -O $sourceUrl/openssl-1.0.1p.tar.gz -O $sourceUrl/pcre-8.39.tar.gz
tar xvf zlib-1.2.8.tar.gz
tar xvf openssl-1.0.1p.tar.gz
tar xvf pcre-8.39.tar.gz
tar xvf nginx-1.10.2.tar.gz
echo "进入nginx目录编译"
cd $version
#
#[可选]
# --conf-path=$webPath/conf/nginx.conf
# --pid-path=$webLog/nginx.pid
# --lock-path=$webLog/nginx.lock
# --http-log-path=$webLog/http.log
# --error-log-path=$webLog/http-error.log
# --with-openssl=../openssl-1.0.1p
# --with-http_stub_status_module
#
./configure --prefix=$webPath --sbin-path=$webPath/sbin/nginx --http-client-body-temp-path=$tempPath/client/ --http-proxy-temp-path=$tempPath/proxy --http-fastcgi-temp-path=$tempPath/fastcgi --http-uwsgi-temp-path=$tempPath/uwsgi --http-scgi-temp-path=$tempPath/scgi --with-http_ssl_module --with-pcre=../pcre-8.39 --with-zlib=../zlib-1.2.8 --user=$webUser --group=$webGroup --with-threads --with-debug
#
make
make install
echo "##################################################################"