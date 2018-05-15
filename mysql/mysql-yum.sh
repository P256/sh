!/usr/bin/bash
clear
#source ../res.sh
######################################################################################################
echo "1.检查系统是否安装mariadb"
rpm -qa | grep mariadb*
yum -y remove mariadb*
echo "2.安装mysql官方yum源"
# 安装mysql的yum源
rpm -ivh https://repo.mysql.com/mysql57-community-release-el7-11.noarch.rpm
#
yum install mysql




