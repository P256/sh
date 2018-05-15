echo "============================安装Coreseek开始=============================="
tar xvf coreseek-3.2.14.tar.gz
cd coreseek-3.2.14
##前提：需提前安装操作系统基础开发库及mysql依赖库以支持mysql数据源和xml数据源
##安装mmseg
cd mmseg-3.2.14
./bootstrap    #输出的warning信息可以忽略，如果出现error则需要解决
./configure --prefix=/usr/local/mmseg
make
make install
cd ..
##安装coreseek
cd csft-3.2.14
sh buildconf.sh    #输出的warning信息可以忽略，如果出现error则需要解决
./configure --prefix=/usr/local/coreseek  --without-unixodbc --with-mmseg --with-mmseg-includes=/usr/local/mmseg/include/mmseg/ --with-mmseg-libs=/usr/local/mmseg/lib/ --with-mysql=/usr/local/mysql --with-mysql-includes=/usr/local/mysql/include --with-mysql-libs=/usr/local/mysql/lib
make
make install
sed -i '$a PATH=/usr/local/coreseek/bin:$PATH \nexport PATH' /etc/profile
source /etc/profile
cd ../
##测试mmseg分词，coreseek搜索（需要预先设置好字符集为zh_CN.UTF-8，确保正确显示中文）
cd testpack
cat var/test/test.xml    #此时应该正确显示中文
/usr/local/mmseg/bin/mmseg -d /usr/local/mmseg/etc var/test/test.xml
indexer -c etc/csft.conf --all
search -c etc/csft.conf 网络搜索
 
#自行配置正式
#cp etc/csft_mysql.conf sphinx-mysql.conf
#indexer -c /usr/local/coreseek/etc/sphinx-mysql.conf --all
#search -c /usr/local/coreseek/etc/sphinx-mysql.conf 网络搜索
#searchd -c /usr/local/coreseek/etc/sphinx-mysql.conf
#searchd -c /usr/local/coreseek/etc/sphinx-mysql.conf --stop
#searchd -c /usr/local/coreseek/etc/sphinx-mysql.conf --status
 
#说明主索引：index_main,增量索引：index_add
#重建主索引和增量索引
#indexer --config /usr/local/coreseek/etc/sphinx-mysql.conf --rotate index_main
#indexer --config /usr/local/coreseek/etc/sphinx-mysql.conf --rotate index_add
#合并建主索引和增量索引
#indexer --config /usr/local/coreseek/etc/sphinx-mysql.conf --merge index_main index_add --merge-dst-range deleted 0 0 -rotate
#重建整个索引
#indexer --config /usr/local/coreseek/etc/sphinx-mysql.conf --rotate --all
 
cd ../
echo "安装libsphinxclient";
cd csft-3.2.14/api/libsphinxclient/
./configure --prefix=/usr/local/libsphinxclient
make
make install
cd /usr/local/src/
echo "安装PHP-sphinx";
tar zxvf sphinx-1.3.3.tgz
cd sphinx-1.3.3
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config --with-sphinx
make;make install
echo "#在文件php.ini中最后一行直接输入extension=sphinx.so"
sed -i '$a extension=sphinx.so' /usr/local/php/etc/php.ini
cd ../
echo "============================安装Coreseek完成=============================="