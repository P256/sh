####################################################################################################

version=grafana-5.2.4
# 二进制版本
curl -O https://dl.grafana.com/oss/release/${version}.linux-amd64.tar.gz
#
tar zxvf ${version}.linux-amd64.tar.gz
#
mv grafana-5.2.4 ../grafana
#
cd ../grafana
#

curl -O https://dl.grafana.com/oss/release/grafana-6.3.4.linux-amd64.tar.gz 
tar zxvf grafana-6.3.4.linux-amd64.tar.gz 