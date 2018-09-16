####################################################################################################
# 二进制版本
curl -O https://nodejs.org/dist/v8.11.4/node-v8.11.4-linux-x64.tar.xz
# 源码版本 （依赖gcc++4.8）
curl -O https://nodejs.org/dist/v8.11.4/node-v8.11.4.tar.gz
#
cd node-v8.11.4
#
./configure --prefix=/usr/local/nodejs
#
make && make install

#npm install -g cnpm --registry=https://registry.npm.taobao.org
#cnpm install -g typescript