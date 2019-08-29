

# 二进制版本
curl -O https://dl.influxdata.com/chronograf/releases/chronograf-1.7.8_linux_amd64.tar.gz
# 二进制版本
curl -O https://dl.influxdata.com/kapacitor/releases/kapacitor-1.5.2_linux_amd64.tar.gz


# 数据存储
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


# 数据收集
# 二进制版本
curl -O https://dl.influxdata.com/telegraf/releases/telegraf-1.10.0_linux_amd64.tar.gz
#
mkdir -p /usr/local/telegraf/etc /usr/local/telegraf/log
#
cp -fr telegraf/usr/bin /usr/local/telegraf/
#
cp -fr telegraf/etc/telegraf/telegraf.conf /usr/local/telegraf/etc/
#
cd /usr/local/telegraf
#
bin/telegraf -config etc/telegraf.conf
# bin/telegraf -sample-config -input-filter cpu:mem:disk -output-filter influxdb > telegraf.conf
# bin/telegraf -sample-config -input-filter cpu:mem:disk -output-filter influxdb > etc/telegraf.conf


# 警告处理


# 视化工具
