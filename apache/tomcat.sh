!/usr/bin/bash
##############################
# 构建持续集成系统 <Jenkins>##
# https://jenkins.io #########
##############################
clear
#source res.sh
######################################################################################################
echo "2.设置Tomcat目录"
tomcatPath=/usr/local/tomcat
# 创建目录
mkdir ${tomcatPath}
######################################################################################################
echo "3.进入源码目录"
# 进入源码目录
cd /usr/local/src
# 设置文件名

# 下载
curl -O http://mirror.bit.edu.cn/apache/tomcat/tomcat-8/v8.5.15/src/apache-tomcat-8.5.15.tar.gz
#
 
#

#关闭firewall：
systemctl stop firewalld.service #停止firewall
systemctl disable firewalld.service #禁止firewall开机启动
firewall-cmd --state #查看默认防火墙状态（关闭后显示notrunning，开启后显示running）