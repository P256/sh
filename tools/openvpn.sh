# 
# https://openvpn.net/index.php/download/community-downloads.html
#
# https://github.com/OpenVPN/openvpn/archive/v2.4.6.tar.gz
# https://github.com/OpenVPN/easy-rsa/archive/v3.0.5.tar.gz
#
# https://blog.csdn.net/jueqi6962/article/details/74332289
# https://blog.csdn.net/fascinatinggirl/article/details/61198362
# https://www.aliyun.com/jiaocheng/138567.html
#
yum install autoconf automake libtool
#
autoreconf -i -v -f
# 
# configure: error: openssl check failed
yum install openssl-devel
# configure: error: route utility is required but missing
yum install net-tools
# configure: error: lzo enabled but missing
yum install lzo-devel
# configure: error: libpam required but missing
yum install pam-devel
#
#
./configure --prefix=/usr/local/openvpn
#
make
make install
# 
mkdir /usr/local/openvpn/etc
# 
cp sample/sample-config-files/server.conf /usr/local/openvpn/etc/server.conf
#
cd ../
# 制作证书 
tar zxvf easy-rsa-3.0.5.tar.gz
#
cd easy-rsa-3.0.5/easyrsa3
#
# 制作证书准备工作:
# 新建一个目录作为证书制作环境
mkdir server client
#
cd server
# 制作根证书
../easyrsa init-pki 				# 初始化证书目录pki
../easyrsa build-ca nopass 			# 创建根证书,提示输入Common Name,名称随意

# 制作服务端证书
../easyrsa gen-req server nopass 	# 创建服务端证书,提示输入Common Name
../easyrsa sign server server 		# 对服务端证书签名,需要输入yes确定
../easyrsa gen-dh 					# 生成dh.pem文件,它能保证在网络中安全交换密钥

# 服务端配置
cp pki/ca.crt /usr/local/openvpn/etc
cp pki/private/server.key /usr/local/openvpn/etc
cp pki/issued/server.crt /usr/local/openvpn/etc
cp pki/dh.pem /usr/local/openvpn/etc

#
cd ../client  						# 在这里制作客户端证书
# 制作根证书
../easyrsa init-pki 				# 初始化证书目录pki
../easyrsa gen-req client nopass 	# 创建客户端证书,提示输入Common Name
../easyrsa import-req pki/reqs/client.req client # 导入客户端证书
../easyrsa sign client client 		# 对客户端证书签名,需要输入yes确定
cd ../


# 配置server.conf


# 开启路由转发支持
vi /etc/sysctl.conf
#net.ipv4.ip_forward = 1
# 生效
sysctl -p

/usr/local/openvpn/sbin/openvpn --config /usr/local/openvpn/etc/server.conf


/usr/local/openvpn/sbin/openvpn --genkey --secert ta.key