!/usr/bin/bash
clear
#source res.sh
#
curl -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.4.0.tar.gz
#
tar zxvf elasticsearch-6.4.0.tar.gz
mv elasticsearch-6.4.0 ../es
#
adduser es
chown es:es ../es -R
su es
../es/bin/elasticsearch -d

#######################################################################################
# 定制目录
#######################################################################################
mkdir /data/es
mkdir /var/log/es
chown es:es /data/es /var/log/es -R

#######################################################################################
# jvm.options
#######################################################################################
-Xms128m
-Xmx128m

#######################################################################################
# elasticsearch.yml
#######################################################################################
# https://blog.csdn.net/qq_34021712/article/details/79342668
#######################################################################################
#
network.bind_host 127.0.0.1 192.168.3.103
network.publish_host 192.168.3.103