yum install psmisc supervisor
yum install telnet-server
yum install tcpdump lsof perf

# 查看端口使用情况
ss -tln
ss -tlnp | grep 4567

# ios
http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1804.iso

界面
  Grafana
  
收集
  Telegraf
  
存储
  Influxdb

工具
  wrk 



参考官方文档

    telegraf: https://docs.influxdata.com/telegraf/v1.0/
    influxdb: https://docs.influxdata.com/influxdb/v1.0
    grafana: http://docs.grafana.org/
    
    
https://blog.csdn.net/li_xue_zhao/article/details/79800140
https://blog.csdn.net/w958660278/article/details/80484486
https://www.jianshu.com/p/378d0005c0a4
https://www.jianshu.com/p/dfd329d30891
https://blog.csdn.net/liurui_wuhan/article/details/79001756
https://blog.csdn.net/liurui_wuhan/article/details/79001756
https://www.cnblogs.com/ycyzharry/p/8372168.html





