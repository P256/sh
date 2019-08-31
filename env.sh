!/bin/bash
clear
######################################################################################################
echo "系统检查"
# 检查环境
cat /etc/redhat-release
# 检查内核
uname -a
# 主机更名
hostnamectl --static set-hostname os
# 检查路由
ip route
# 设置hosts
cat >>/etc/hosts<<EOF
192.168.1.6 os
EOF
# 静态路由
sed -i 's/dhcp/static/' /etc/sysconfig/network-scripts/ifcfg-enp0s3
cat >>/etc/sysconfig/network-scripts/ifcfg-enp0s3<<EOF
IPADDR=192.168.1.6
GATEWAY=192.168.1.1
NETMASK=255.255.255.0
DNS1=192.168.1.1
EOF
# 重启网络
service network restart
#
######################################################################################################
echo '系统YUM源'
# 备份源文件
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
# 下载源文件
# curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
# 安装epel源
# yum install epel-release -y
# 清理缓存
yum clean all
# 生成缓存
yum makecache
# 检查是否已添加至源列表
yum repolist
######################################################################################################
echo "常用工具"
# 安装常用的编译工具
# yum install gcc gcc-c++ -y
# 测试工具
# yum install sysbench
# 工具类
# yum install psmisc supervisor telnet tcpdump lsof perf
######################################################################################################
echo '系统安全'
# 永久关闭 SELinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
# 关闭防火墙
systemctl disable firewalld
######################################################################################################