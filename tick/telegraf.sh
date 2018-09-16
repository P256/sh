####################################################################################################
# 二进制版本
curl -O https://dl.influxdata.com/telegraf/releases/telegraf-1.7.4_linux_amd64.tar.gz
#
mkdir ../telegraf ../telegraf/etc
#
cp -fr ./telegraf/usr/bin ../telegraf/
#
cp -fr ./telegraf/etc/telegraf/telegraf.conf ../telegraf/etc/
#
cd ../telegraf
#
./bin/telegraf -config ./etc/telegraf.conf
