!/usr/bin/bash
clear
#source res.sh
######################################################################################################
echo "2.����jreĿ¼"
jrePath=/usr/local/jre
jreBin=${jrePath}/bin
# ����Ŀ¼
mkdir ${jrePath}
######################################################################################################
echo "3.����Դ��Ŀ¼"
# ����Դ��Ŀ¼
cd /usr/local/src
# �����ļ���
jreFile=jre-8u131-linux-x64.tar.gz
jreFileDir=jre1.8.0_131
# �����ļ�
#http://sdlc-esd.oracle.com/ESD6/JSCDL/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jre-8u131-linux-x64.tar.gz?GroupName=JSC&FilePath=/ESD6/JSCDL/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jre-8u131-linux-x64.tar.gz&BHost=javadl.sun.com&File=jre-8u131-linux-x64.tar.gz&AuthParam=1495620898_444a97953831a3ba5e9bc4a9f64492cd&ext=.gz
#
# jre-8u131-linux-x64.tar.gz
curl -O ${jreFile}
# ��ѹ�ļ�
tar -xvf ${jreFile}
# �ƶ�
mv $jreFileDir/* ${jrePath}
# ���û�������
sed -i '$a JAVA_HOME='${jrePath} /etc/profile
sed -i '$a CLASSPATH=.:$JAVA_HOME/lib/' /etc/profile
sed -i '$a PATH=$PATH:$JAVA_HOME/bin' /etc/profile
sed -i '$a export PATH JAVA_HOME CLASSPATH' /etc/profile
source /etc/profile
######################################################################################################
