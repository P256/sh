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