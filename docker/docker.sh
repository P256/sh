!/bin/bash
##########################################################################
##	docker
##########################################################################
yum install docker -y
#
systemctl enable docker
# 
cat <<EOF > /etc/docker/daemon.json
{
  "registry-mirrors": ["https://bmmsq0wm.mirror.aliyuncs.com"],
  "graph": "/data/docker"
}
EOF
#
systemctl start docker
# 
docker info
##########################################################################
##	构建私有仓库
# 	参考
# 	https://blog.51cto.com/andyxu/2175081
# 	https://www.cnblogs.com/wade-luffy/p/6497502.html
##########################################################################
#
# 下载registry镜像
docker pull registry
#
mkdir -p /data/docker/registry
#
docker run -itd -p 192.168.1.3:5000:5000 -v /data/docker/registry:/var/lib/registry --restart=always --name registry registry
#
curl http://192.168.1.3:5000/v2/_catalog
# 
cat <<EOF > /etc/docker/daemon.json
{
  "registry-mirrors": ["https://bmmsq0wm.mirror.aliyuncs.com"],
  "graph": "/data/docker",
  "insecure-registries": ["192.168.1.3:5000"]
}
EOF
#
systemctl restart docker

##########################################################################
# 测试
##########################################################################
# 获取镜像
docker pull nginx
# 打个标签
docker tag nginx 192.168.1.3:5000/nginx:v1
# 镜像上传
docker push 192.168.1.3:5000/nginx:v1
##########################################################################
#
docker pull docker.io/tianyebj/pod-infrastructure
#
docker tag tianyebj/pod-infrastructure 192.168.1.3:5000/pod-infrastructure
#
docker push 192.168.1.3:5000/pod-infrastructure
##########################################################################
# docker pull registry.cn-shanghai.aliyuncs.com/yfkj/nginx
# docker login --username=suc168 registry.cn-shanghai.aliyuncs.com
# docker tag nginx registry.cn-shanghai.aliyuncs.com/yfkj/nginx
# docker push registry.cn-shanghai.aliyuncs.com/yfkj/nginx

##########################################################################
# 工具
##########################################################################
# compose
curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

# machine
curl -L https://github.com/docker/machine/releases/download/v0.13.0/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine

#
chmod +x /usr/local/bin/docker-machine

#
chmod +x /usr/local/bin/docker-compose

# 
docker-compose help

#
docker-machine help


