#####################################################################################################################

# 1.检查内核版本(Docker要求CentOS系统的内核版本高于3.10)
uname –r
# 
cat /etc/redhat-release
cat /etc/hosts

# http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# https://download.docker.com/linux/centos/docker-ce.repo
# 2.添加镜像源
curl -o /etc/yum.repos.d/docker-ce.repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 3.将软件包添加至本地缓存
yum makecache fast

# 4.安装docker-ce
yum list|grep docker | sort -r
yum install docker-ce
# yum install docker

# 5.启动docker
systemctl start docker
systemctl enable docker


docker pull nginx

docker run -d --name nginx -p 80:80 nginx -it bash
docker run -d --name nginx -p 80:80 nginx:latest

# docker信息
docker info
# docker版本
docker version
# docker镜像
docker images
# 
docker ps -a

#
#Dockerfile
#
#ip addr
#https://docs.docker.com/linux/started/
#https://github.com/boot2docker/windows-installer/releases
##http://mirrors.aliyun.com/docker-engine/yum/
