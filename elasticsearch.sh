#!/usr/bin/bash
clear
#设置资源来源
sourceUrl="http://192.168.2.16/"
cd /usr/local/src
echo "###############################################################################"
#设置安装路径
filePath=/usr/local/jre
version=8u121
echo "Install jre"
curl -O ${sourceUrl}/jre-${version}-linux-x64.tar.gz
tar -zxvf jre-${version}-linux-x64.tar.gz
mv jre1.8.0_121 ${filePath}
#配置环境变量
sed -i '$a JAVA_HOME='${filePath} /etc/profile
sed -i '$a CLASSPATH=.:$JAVA_HOME/lib/' /etc/profile
sed -i '$a PATH=$PATH:$JAVA_HOME/bin' /etc/profile
sed -i '$a export PATH JAVA_HOME CLASSPATH' /etc/profile
source /etc/profile
echo "Install jre finish"
echo "###############################################################################"
#设置安装路径
filePath=/usr/local/es
version=5.1.2
echo "Install elasticsearch "
curl -O ${sourceUrl}/elasticsearch-${version}.tar.gz
tar -zxvf elasticsearch-${version}.tar.gz
mv elasticsearch-${version} ${filePath}
mkdir ${filePath}/data
mkdir ${filePath}/logs
#配置elasticsearch
vi ${filePath}/config/elasticsearch.yml
#cluster.name: f256
#node.name: node-1
#network.host: 192.168.2.19
#
#jvm.options
#-Xms256m
#-Xmx256m
#
#配置es用户
adduser es
chown -R es:es ${filePath}
#配置elasticsearch<增加两行>
vi ${filePath}/bin/elasticsearch
#ES_HEAP_SIZE=4g
#MAX_OPEN_FILES=65535
echo "Install elasticsearch finish"
echo "###############################################################################"
echo "启动ES"
su es
#/usr/local/es/bin/elasticsearch -d
#ps -aux | grep elasticsearch
#echo "###############################################################################"
#启动错误
#max file descriptors [4096] for elasticsearch process is too low, increase to at least [65536]
#/etc/security/limits.conf	<加入es soft nofile 65536 es hard nofile 65536>
#sed -i '$a @es soft nofile 65536' /etc/security/limits.conf
#sed -i '$a @es hard nofile 65536' /etc/security/limits.conf
#bin/elasticsearch <加入-Des.max-open-files=ture>
#sed -i '$a -Des.max-open-files=ture' ${filePath}/bin/elasticsearch
#
#max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
#vm.max_map_count参数设置太小导致的
#sysctl -w vm.max_map_count=655360
#sysctl -a | grep "vm.max_map_count"
#/etc/sysctl.conf <加入:vm.max_map_count=262144>
#sed -i '$a vm.max_map_count=262144' /etc/sysctl.conf
#
#echo "###############################################################################"