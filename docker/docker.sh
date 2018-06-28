# 1检查内核版本(Docker 要求 CentOS 系统的内核版本高于 3.10)
uname –r
#####################################################################################################################

# 2.1加入epel源
yum install docker
# 2.2加入官方docker源
tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
# 2.3下载官方docker包
#https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-1.12.5-1.el7.centos.x86_64.rpm
#https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-selinux-1.12.5-1.el7.centos.noarch.rpm
# 安装docker包<8个依赖包policycoreutils-python/libseccomp/libtool-ltdl>
yum install docker-engine
#####################################################################################################################

# docker启动
systemctl start docker
# docker信息
docker info
# docker版本
docker version
# docker镜像
docker images
# 
docker ps -a
#
chkconfig docker on
#
#Dockerfile
#
#ip addr
#https://docs.docker.com/linux/started/
#https://github.com/boot2docker/windows-installer/releases
##http://mirrors.aliyun.com/docker-engine/yum/
