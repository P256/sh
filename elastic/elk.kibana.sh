#!/usr/bin/bash
clear
#设置资源来源
sourceUrl="http://192.168.100.83/packet"
cd /usr/local/src
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
#通过zip压缩包 <支持本地和远程HTTP下载两种>
#指定URL安装 <http://192.168.100.83/packet/sense-2.0.0-beta5.tar.gz>
#bin/kibana plugin -i sense -u file:///tmp/sense-2.0.0-beta1.tar.gz
#bin/kibana plugin -i heatmap -u https://github.com/stormpython/heatmap/archive/master.zip
#bin/kibana plugin -i kibi_timeline_vis -u https://github.com/sirensolutions/kibi_timeline_vis/raw/0.1.2/target/kibi_timeline_vis-0.1.2.zip
#bin/kibana plugin -i oauth2 -u https://github.com/trevan/oauth2/releases/download/0.1.0/oauth2-0.1.0.zip
echo "###############################################################################"