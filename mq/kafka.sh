# apache 
http://archive.apache.org/dist/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz
http://archive.apache.org/dist/kafka/2.0.0/kafka_2.11-2.0.0.tgz


# zookeeper
#https://zookeeper.apache.org/
#https://zookeeper.apache.org/releases.html
#http://archive.apache.org/dist/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz

tar zxvf zookeeper-3.4.9.tar.gz
mv zookeeper-3.4.9 ../zookeeper

#
# kafka
#http://kafka.apache.org/downloads.html
#https://www.cnblogs.com/justuntil/p/8033792.html

#
curl -O http://mirrors.tuna.tsinghua.edu.cn/apache/kafka/2.0.0/kafka_2.12-2.0.0.tgz
#
tar zxvf kafka_2.12-2.0.0.tgz
mv kafka_2.12-2.0.0 ../kafka
#
# 启动broker
bin/kafka-server-start.sh config/server.properties
#
#结束
bin/kafka-server-stop.sh
# 
ss -lnp | grep 2181

