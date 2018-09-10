!/usr/bin/bash
clear
#source res.sh
#
curl -O https://artifacts.elastic.co/downloads/kibana/kibana-6.4.0-linux-x86_64.tar.gz
#
tar zxvf kibana-6.4.0-linux-x86_64.tar.gz
#
mv kibana-6.4.0-linux-x86_64 ../kibana
#
#######################################################################################
# kibana.yml
#######################################################################################
vi ../kibana/config/kibana.yml
# 
#server.host "192.168.1.62"
#server.name: "kibana"
#elasticsearch.url "http://192.168.1.62:9200"

#######################################################################################
# plugin
#######################################################################################
# list
../kibana/bin/kibana-plugin list

