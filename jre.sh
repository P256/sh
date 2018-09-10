!/usr/bin/bash
clear
#source res.sh
# jre url
# https://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html
#
# src
cd /usr/local/src
tar zxvf jre-8u181-linux-x64.tar.gz
mv jre1.8.0_181 ../jre
# env
vi /etc/profile
#######################################################################################
# jre env
export JRE_HOME=/usr/local/jre
export CLASSPATH=$JRE_HOME/lib/
export PATH=$JRE_HOME/bin:$PATH
# jre env
sed -i '$a JRE_HOME=/usr/local/jre' /etc/profile
sed -i '$a CLASSPATH=.:$JRE_HOME/lib/' /etc/profile
sed -i '$a PATH=$PATH:$JRE_HOME/bin' /etc/profile
sed -i '$a export PATH JRE_HOME CLASSPATH' /etc/profile
# fulsh
source /etc/profile
#######################################################################################
