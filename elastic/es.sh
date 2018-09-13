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
# jvm.options
#######################################################################################
-Xms128m
-Xmx128m

#######################################################################################
# elasticsearch.yml
#######################################################################################
# https://blog.csdn.net/qq_34021712/article/details/79342668
# https://www.cnblogs.com/blogjun/articles/8086193.html
# https://www.elastic.co/guide/cn/elasticsearch/guide/current/get-doc.html
#######################################################################################
