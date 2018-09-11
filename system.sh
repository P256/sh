##########################################################################################
# 防火墙开启80端口
# 命令含义
# --zone #作用域 
# --add-port=80/tcp  #添加端口,格式为：端口/通讯协议
# --permanent   #永久生效,没有此参数重启后失效
firewall-cmd --zone=public --add-port=80/tcp --permanent
# 重启防火墙
firewall-cmd --reload
# 停止
systemctl stop firewalld.service
# 禁止
systemctl disable firewalld.service
# 状态
systemctl status firewalld.service
#
##########################################################################################




###########################################################################################
# 
mount -l
# 挂载win共享文件夹
mount -t cifs -o username="S256",password="sa123456",rw,dir_mode=0775,file_mode=0775,uid=994,gid=992 //192.168.8.1/code/php /data/web
# 卸载win共享文件夹
umount /data/web
# 如：
#mount -t cifs -o username="S256",password="sa123456",rw,dir_mode=0775,file_mode=0775,uid=995,gid=993 //192.168.8.1/code/php /data/web
#mount -t cifs -o username="S256",password="sa123456" //192.168.8.1/code/pack /
###########################################################################################





######################################################################################################
# 查看安装历史
yum history list packName
# 回退某个安装版本
yum history undo 7

rpm -qa php
rpm -qa | wc -l
rpm -qa | sort
###########################################################################################







