# jre
# https://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html
#
tar zxvf jre-8u181-linux-x64.tar.gz
mv jre1.8.0_181 jre
mv jre ../
#
# 配置环境变量
vi /etc/profile
####################################################################################################
# jre
export JRE_HOME=/usr/local/java
export CLASSPATH=$JRE_HOME/lib/
export PATH=$JRE_HOME/bin:$PATH
#
source /etc/profile
#
curl -O　https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.4.0.tar.gz
#
tar zxvf elasticsearch-6.4.0.tar.gz
#
mv elasticsearch-6.4.0 es
mv es ../
cd ../
adduser es
chown es:es es -R
su es
./bin/elasticsearch
############################################################################################################
# 配置文件
# https://blog.csdn.net/qq_34021712/article/details/79342668
############################################################################################################


############################################################################################################
# 错误[1]: max file descriptors [4096] for elasticsearch process is too low, increase to at least [65536
############################################################################################################
vi /etc/security/limits.conf 
* soft nofile 65536
* hard nofile 131072
* soft nproc 2048
* hard nproc 4096
# 退出再登录

############################################################################################################
# 错误[2]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
############################################################################################################
vi /etc/sysctl.conf
vm.max_map_count = 655360
# 
sysctl -p

############################################################################################################
# 错误参考：https://www.cnblogs.com/sloveling/p/elasticsearch.html
############################################################################################################






