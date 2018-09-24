!/usr/bin/bash
clear
######################################################################################################
echo "0.系统检查"
# 环境检查
cat /etc/redhat-release
# 检查内核版本
#uname
# 路由检查
ip route show
# 可设置静态IP
#vi /etc/sysconfig/network-scripts/ifcfg-enp0s3
# 修改如下内容
#BOOTPROTO="dhcp"
#BOOTPROTO="static"
#IPADDR=192.168.1.10
#GATEWAY=192.168.1.1
#NETMASK=255.255.255.0
#DNS1=192.168.1.1
#service network restart
#
######################################################################################################
echo '1.系统yum源'
# 进入源目录
cd /etc/yum.repos.d/
# 备份源文件
mv CentOS-Base.repo CentOS-Base.repo.backup
# 下载163源文件
curl -O http://mirrors.163.com/.help/CentOS7-Base-163.repo
# 安装epel源
yum install epel-release
# 清理缓存
yum clean all
# 生成缓存
yum makecache
# 检查是否已添加至源列表
yum repolist
######################################################################################################
echo "2.资源目录"
# 设置数据目录
dataDir=/data
dataLog=/data/log
# 创建数据目录
mkdir $dataDir $dataLog
# 安装常用的编译工具
yum -y install gcc gcc-c++

