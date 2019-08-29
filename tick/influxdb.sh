# 二进制版本
curl -O https://dl.influxdata.com/influxdb/releases/influxdb-1.7.4_linux_amd64.tar.gz
#
mv influxdb-1.7.4-1 influxdb
#
mkdir -p /usr/local/influxdb/etc /usr/local/influxdb/log
#
cp -fr influxdb/usr/bin /usr/local/influxdb/
#
cp -fr influxdb/etc/influxdb/influxdb.conf /usr/local/influxdb/etc/
#
cd /usr/local/influxdb
#
bin/influxd -config etc/influxdb.conf











