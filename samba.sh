# 源码地址
#curl -O https://download.samba.org/pub/samba/stable/samba-4.6.4.tar.gz

# 先检查下是否已经安装
rpm -qa | grep samba

# 简单安装-<samba-client暂不安装>
yum install samba

# 备份smb.conf
cp /etc/samba/smb.conf /etc/samba/smb.conf.bakup

# 编辑smb.conf
vim /etc/samba/smb.conf

# 创建用户组
groupadd web

# 添加用户并授予主目录和分组，并不能登录
useradd data -d /data -s /sbin/nologin -g data

# 修改用户主目录
usermod -d /data/web data

# 创建samba用户(这个是系统用户)并给每个用户设置密码
smbpasswd  -a web

# 设置用户密码
pdbedit -a -u web

# 查看smb用户
pdbedit -L

# 删除smb用户
smbpasswd -x web

# 启动
service smb start
# 开机启动
chkconfig smb on

# 查看yum安装列表
yum history list

# 定义
#1.service smb status        #查看smd服务的状态
#2.service smb start           #运行smb服务
#3.service smb stop           #停止服务
#4.service smb restart       #重启服务，但在实际中一般不采用
#5.service smb reload       #重载服务，在实际中较常用，不用停止服务

# 关闭防火墙
systemctl stop firewalld.service

# 关闭SELinux的两种方式：临时关闭和永久关闭
# 1.临时关闭
# setenforce 0 设置SELinux为permissive模式
# setenforce 1 设置SELinux为enforcing模式
setenforce 0
# 2.永久关闭          
# 修改配置文件并重启 <SELINUX=enforcing 改为 SELINUX=disabled>
vim /etc/selinux/config

# 配置文件说明
vim /etc/samba/smb.conf

