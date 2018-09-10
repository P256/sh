#!/usr/bin/bash
clear
#设置资源来源
sourceUrl="http://192.168.100.83/packet"
cd /usr/local/src
echo "###############################################################################"
#设置ES安装路径
filePath=/usr/local/es
echo "ES安装插件 license marvel-agent"
${filePath}/bin/plugin install license
${filePath}/bin/plugin install marvel-agent
#${filePath}/bin/plugin install mobz/elasticsearch-head
echo "###############################################################################"
#设置安装路径
filePath=/usr/local/logstash
echo "Install logstash"
curl -O ${sourceUrl}/logstash-2.3.2.tar.gz
tar -zxvf logstash-2.3.2.tar.gz
mv logstash-2.3.2 ${filePath}
mkdir -p ${filePath}/conf
echo "Install logstash finish"
echo "###############################################################################"
#设置安装路径
filePath=/usr/local/kibana
echo "Install kibana"
#编译安装
curl -O ${sourceUrl}/kibana-4.5.1-linux-x64.tar.gz
tar -zxvf kibana-4.5.1-linux-x64.tar.gz
mv kibana-4.5.1-linux-x64 ${filePath}
#配置kibana
vi ${filePath}/config/kibana.yml
#server.host "192.168.100.62"
#elasticsearch.url "http://192.168.100.62:9200"
echo "kibana plugin install marvel"
${filePath}/bin/kibana plugin --install elasticsearch/marvel/latest
echo "kibana plugin install Sense"
${filePath}/bin/kibana plugin --install elastic/sense
echo "###############################################################################"