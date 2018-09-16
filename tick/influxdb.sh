####################################################################################################
# 二进制版本
curl -O https://dl.influxdata.com/influxdb/releases/influxdb-1.6.2_linux_amd64.tar.gz
#
mkdir ../influxdb ../influxdb/etc ../influxdb/log /data/influxdb
#
cp -fr ./influxdb-1.6.2-1/usr/bin ../influxdb/
#
cp -fr ./influxdb-1.6.2-1/etc/influxdb/influxdb.conf ../influxdb/etc
#
cd ../influxdb
#
./bin/influxd -config ./etc/influxdb.conf
#











