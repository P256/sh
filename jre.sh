!/usr/bin/bash
clear
#source res.sh
######################################################################################################
echo "2.设置jre目录"
jrePath=/usr/local/jre
jreBin=${jrePath}/bin
# 创建目录
mkdir ${jrePath}
######################################################################################################
echo "3.进入源码目录"
# 进入源码目录
cd /usr/local/src
# 设置文件名
jreFile=jre-8u131-linux-x64.tar.gz
jreFileDir=jre1.8.0_131
# 下载文件
#http://sdlc-esd.oracle.com/ESD6/JSCDL/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jre-8u131-linux-x64.tar.gz?GroupName=JSC&FilePath=/ESD6/JSCDL/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jre-8u131-linux-x64.tar.gz&BHost=javadl.sun.com&File=jre-8u131-linux-x64.tar.gz&AuthParam=1495620898_444a97953831a3ba5e9bc4a9f64492cd&ext=.gz
#
# jre-8u131-linux-x64.tar.gz
curl -O ${jreFile}
# 解压文件
tar -xvf ${jreFile}
# 移动
mv $jreFileDir/* ${jrePath}
# 配置环境变量
sed -i '$a JAVA_HOME='${jrePath} /etc/profile
sed -i '$a CLASSPATH=.:$JAVA_HOME/lib/' /etc/profile
sed -i '$a PATH=$PATH:$JAVA_HOME/bin' /etc/profile
sed -i '$a export PATH JAVA_HOME CLASSPATH' /etc/profile
source /etc/profile
######################################################################################################
