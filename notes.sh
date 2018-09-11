######################################################################################################
#
uname -a
# 检查内核版本
uname –r
#
cat /etc/redhat-release
# 检查内核版本
uname –r
#
df -H
# 统计目录(或文件)所占磁盘空间
du -sh 
# 查看磁盘
df -Th
# 查看CPU型号,总个数
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c
# 查看硬盘挂载
fdisk -l
# 
mount -l
#
history
#
lsblk -l

#
yum install psmisc supervisor telnet tcpdump lsof perf

# 查看端口使用情况
ss -tln
ss -tlnp | grep 4567



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








