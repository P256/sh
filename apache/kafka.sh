# 官方
# http://kafka.apache.org/downloads.html
# https://zookeeper.apache.org/releases.html
# https://archive.apache.org/dist/
# 源码版
# http://mirrors.hust.edu.cn/apache/kafka/2.0.0/kafka-2.0.0-src.tgz
# 二进制
# http://mirrors.hust.edu.cn/apache/kafka/2.0.0/kafka_2.12-2.0.0.tgz
# 参考
# https://www.cnblogs.com/justuntil/p/8033792.html
#
#######################################################################################
#
curl -L -O http://mirrors.hust.edu.cn/apache/kafka/2.0.0/kafka_2.12-2.0.0.tgz
#
tar zxvf kafka_2.12-2.0.0.tgz
#
mv kafka_2.12-2.0.0 kafka
#
mv kafka ../
#
#######################################################################################
#
# http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-3.4.13/zookeeper-3.4.13.tar.gz
# https://archive.apache.org/dist/zookeeper/zookeeper-3.4.13/zookeeper-3.4.13.tar.gz
curl -L -O http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-3.4.13/zookeeper-3.4.13.tar.gz
#
tar zxvf zookeeper-3.4.13.tar.gz
#
mv zookeeper-3.4.13 zookeeper
#
mv zookeeper ../
