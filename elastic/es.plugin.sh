!/usr/bin/bash
clear
#source res.sh

#######################################################################################
# kibana
#######################################################################################
# 
curl -O https://artifacts.elastic.co/downloads/kibana/kibana-6.4.0-linux-x86_64.tar.gz
#
tar zxvf kibana-6.4.0-linux-x86_64.tar.gz
#
mv kibana-6.4.0-linux-x86_64 ../kibana
#
../kibana/bin/kibana
#######################################################################################


#######################################################################################
# logstash
#######################################################################################
#
curl -O https://artifacts.elastic.co/downloads/logstash/logstash-6.4.0.tar.gz
#
tar zxvf logstash-6.4.0.tar.gz
#
mv logstash-6.4.0 ../logstash
#
mv ../logstash/config/logstash-sample.conf ../logstash/config/logstash.conf
#
../logstash/bin/logstash -f logstash.conf
#######################################################################################


#######################################################################################
# filebeat
#######################################################################################
#
curl -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.4.0-linux-x86_64.tar.gz
# 