#####################################################################################################################

# 1.检查内核版本(Docker要求CentOS系统的内核版本高于3.10)
uname –r

# 2.yum方式
yum install docker

# docker启动
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
