#检查内核版本
uname –r
#加入docker源
tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
#http://mirrors.aliyun.com/docker-engine/yum/
#https://yum.dockerproject.org/repo/main/centos/7/Packages/
#https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-1.12.5-1.el7.centos.x86_64.rpm
#https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-selinux-1.12.5-1.el7.centos.noarch.rpm
#安装docker包<8个依赖包policycoreutils-python/libseccomp/libtool-ltdl>
yum install docker-engine
#启动docker服务
service docker start
#docker信息
docker info
#docker版本
docker version
#ip addr
#
docker images
#
docker ps -a
#
chkconfig docker on
#
#Dockerfile
#
#https://docs.docker.com/linux/started/
#https://github.com/boot2docker/windows-installer/releases