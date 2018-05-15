uname -a
 
history
 
lsblk -l
 
ip route show
 
rpm -qa packet
#设置静态IP地址
vi /etc/sysconfig/network-scripts/ifcfg-eth0
#修改如下内容
#BOOTPROTO="static" #dhcp改为static   
#ONBOOT="yes" #开机启用本配置  
#IPADDR=192.168.100.86 #静态IP  
#GATEWAY=192.168.100.11 #默认网关  
#NETMASK=255.255.255.0 #子网掩码  
#DNS1=192.168.100.11 #DNS 配置
service network restart

cat /etc/redhat-release

rpm -qa | wc -l
rpm -qa | sort

#检查内核版本
uname –r
#查看磁盘
df -Th

######################################################################################################################################################################################
#直接关闭防火墙
systemctl stop firewalld.service #停止firewall
systemctl disable firewalld.service #禁止firewall开机启动
systemctl status firewalld.service #firewall 状态
#
######################################################################################################################################################################################
#设置 iptables service
yum -y install iptables-services

#如果要修改防火墙配置，如增加防火墙端口3306
vi /etc/sysconfig/iptables 

#增加规则
-A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT

#保存退出后
systemctl restart iptables.service #重启防火墙使配置生效
systemctl enable iptables.service #设置防火墙开机启动

#最后重启系统使设置生效即可
######################################################################################################################################################################################