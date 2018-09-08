参考官方文档

    telegraf: https://docs.influxdata.com/telegraf/v1.0/
    influxdb: https://docs.influxdata.com/influxdb/v1.0
    grafana:  http://docs.grafana.org/
    nodejs:   https://nodejs.org/en/docs/
    
    https://blog.csdn.net/li_xue_zhao/article/details/79800140
    https://blog.csdn.net/w958660278/article/details/80484486
    https://www.jianshu.com/p/378d0005c0a4
    https://www.jianshu.com/p/dfd329d30891
    https://blog.csdn.net/liurui_wuhan/article/details/79001756
    https://blog.csdn.net/liurui_wuhan/article/details/79001756
    https://www.cnblogs.com/ycyzharry/p/8372168.html


界面
  Grafana

收集
  Telegraf
  
存储
  Influxdb

工具
  wrk 


# 二进制版本
curl -O https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.2.4.linux-amd64.tar.gz
tar -zxvf grafana-5.2.4.linux-amd64.tar.gz
# RPM包
wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.2.4-1.x86_64.rpm
yum localinstall grafana-5.2.4-1.x86_64.rpm
# 源码包 - 需要Node+Go支持
#


