yum install psmisc supervisor
 
yum install tcpdump lsof perf

# 查看端口使用情况
ss -tln
ss -tlnp | grep 4567
