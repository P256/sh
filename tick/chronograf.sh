# 二进制版本
curl -O https://dl.influxdata.com/chronograf/releases/chronograf-1.7.8_linux_amd64.tar.gz
#
mv chronograf-1.7.8-1 chronograf
#
mkdir -p /usr/local/chronograf/etc /usr/local/chronograf/log
#
cp -fr chronograf/usr/bin /usr/local/chronograf/
#
cd /usr/local/chronograf
#
bin/chronograf -config etc/chronograf.conf

