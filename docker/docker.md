## 参考
https://blog.csdn.net/xiaochendefendoushi/article/details/80979905
https://www.cnblogs.com/yfalcon/p/9044246.html

---
## 显示官方
> docker search centos  --filter "is-official=true"

## 过滤热度
> docker search centos --stars=3

---
### Registry
> docker pull private-registry.com/user-name/ubuntu:latest

### Docker Hub
> docker pull ubuntu

---
### 容器操作
	docker create 容器名或者容器ID	创建容器
	docker start [-i] 容器名			启动容器
	docker run 容器名或者容器ID    	运行容器，相当于docker create + docker start
	docker attach 容器名或者容器ID 	进入容器的命令行
	docker stop 容器名             	停止容器
	docker rm 容器名               	删除容器
	docker top 容器名          		查看WEB应用程序容器的进程
	docker inspect 容器名 			查看Docker的底层信息
	docker port 容器id            	查看到容器的端口映射
	docker logs 容器名或者容器ID 		查看日志
	docker kill 容器名      			直接关闭容器

--- 
### 创建映射端口为88的交互式界面：
docker run -p 88 --name web -i -t ubuntu /bin/bash

### 创建映射端口为86的交互式界面：
docker run -p 88:22 --name cos -i -t centos /bin/bash

### 直接在docker里面运行bash
docker exec -i -t nginx /bin/bash

### 进入容器
docker exec -it cos bash



### 编译镜像
docker build -t yf-nginx:v1 .

### 运行实例
docker run --name nginx -p 60:80 -d yf-nginx:v1

### 定义信息
docker tag  c9d76aeae590  yf-nginx:v2

### 进入容器
docker exec -it nginx bash


---
##### 随笔
docker run --name nginx nginx

docker run --name nginx -p 83:80 -d -t -i nginx

docker run --name tomcat -p 6161:8080 -d -t -i tomcat

docker run --name tomcat -p 8080:8080 -d -t -i tomcat -v /usr/local/tomcat/webapps:/data/java /bin/bash

docker exec -it tomcat /bin/bash

docker cp wopenbase.war tomcat:/usr/local/tomcat/webapps

docker run -v /usr/local/tomcat/webapps:/data/java tomcat

docker run --name php -p 9001:9000 -d -t -i php
docker exec -it php /bin/bash

docker run --name centos centos


docker run -d --name influxdb --net monitor -p 8083:8083 -p 8086:8086 influxdb

---
### 
docker rm nginx

docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs docker rm

docker ps -a | grep Exit | awk '{ print $1}'  | xargs sudo docker rm

docker rm $(docker ps --all -q -f status=exited)








