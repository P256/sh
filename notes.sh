# 环境
cat /etc/redhat-release
#检查内核版本
uname –r
#
ip route show
#
rpm -qa packet
rpm -qa | wc -l
rpm -qa | sort
#
history
#
lsblk -l

######################################################################################################
#设置静态IP地址
vi /etc/sysconfig/network-scripts/ifcfg-enp0s3
#修改如下内容
#BOOTPROTO="static"
#IPADDR=192.168.1.10
#GATEWAY=192.168.1.1
#NETMASK=255.255.255.0
#DNS1=192.168.1.1
service network restart
######################################################################################################


######################################################################################################
#https://linux.cn/article-5926-1.html
#Systemctl
systemctl --version
#检查systemd是否运行
ps -eaf | grep [s]ystemd
#分析systemd启动进程
systemd-analyze
#分析启动时各个进程花费的时间
systemd-analyze blame
######################################################################################################


######################################################################################################
yum install -y gcc gcc-c++
#
touch setup.sh
chmod +x setup.sh
vi setup.sh
######################################################################################################


######################################################################################################
# 防火墙开启80端口
# 命令含义
# --zone #作用域 
# --add-port=80/tcp  #添加端口,格式为：端口/通讯协议
# --permanent   #永久生效,没有此参数重启后失效
firewall-cmd --zone=public --add-port=80/tcp --permanent
# 重启防火墙
firewall-cmd --reload
#
# 关闭防火墙
systemctl stop firewalld.service
# 关闭开机启动
systemctl disable firewalld.service
# https://github.com/xiayulei/notebook/issues/33
#
######################################################################################################

######################################################################################################
df -H
# 统计目录(或文件)所占磁盘空间
du -sh 
# 
mount -l
# 查看硬盘挂载
fdisk -l
#

# 挂载win共享文件夹
mount -t cifs -o username="S256",password="sa123456",rw,dir_mode=0775,file_mode=0775,uid=994,gid=992 //192.168.8.1/code/php /data/web
# 卸载win共享文件夹
umount /data/web
# 如：
#mount -t cifs -o username="S256",password="sa123456",rw,dir_mode=0775,file_mode=0775,uid=995,gid=993 //192.168.8.1/code/php /data/web
#mount -t cifs -o username="S256",password="sa123456" //192.168.8.1/code/pack /


######################################################################################################
# 查看安装历史
yum history list packName
# 回退某个安装版本
yum history undo 7