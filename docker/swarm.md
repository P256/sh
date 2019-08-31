### 参考
	https://www.cnblogs.com/xishuai/p/docker-swarm.html

---
### 开放端口
	2377：TCP端口2377用于集群管理通信
	7946：TCP和UDP端口7946用于节点之间的通信
	4789：TCP和UDP端口4789用于覆盖网络流量

### docker swarm 常用命令
	docker swarm init				初始化集群
	docker swarm join				加入集群中
	docker swarm join-token worker	查看工作节点的 token
	docker swarm join-token manager	查看管理节点的 token

### docker stack 常用命令
	docker stack deploy		部署新的堆栈或更新现有堆栈
	docker stack ls			列出现有堆栈
	docker stack ps			列出堆栈中的任务
	docker stack rm			删除堆栈
	docker stack services	列出堆栈中的服务
	docker stack down		移除某个堆栈（不会删除数据）

### docker node 常用命令
	docker node ls			查看所有集群节点
	docker node rm			删除某个节点（-f强制删除）
	docker node inspect		查看节点详情
	docker node demote		节点降级，由管理节点降级为工作节点
	docker node promote		节点升级，由工作节点升级为管理节点
	docker node update		更新节点
	docker node ps			查看节点中的 Task 任务

### docker service 常用命令
	docker service create	部署服务
	docker service inspect	查看服务详情
	docker service logs		产看某个服务日志
	docker service ls		查看所有服务详情
	docker service rm		删除某个服务（-f强制删除）
	docker service scale	设置某个服务个数
	docker service update	更新某个服务



---
### 随笔

### network
	docker network create --driver=overlay --attachable app

### swarm
	docker swarm init --advertise-addr 192.168.1.69
	
	docker swarm join --token SWMTKN-1-3lttlub2xpypnvsu05z98xn5e9j5fc9p7j5wlssld593mwvpza-bg605ksh27mwmyc6xqynml3m3 192.168.1.69:2377

	docker swarm join --token SWMTKN-1-5746nn76qhiobplcxopqlovv979flq7f4pie5qluk8ag8wujts-dzsb4yj8ejrr0opxqvjqm3b4d 192.168.1.69:2377

### stack
	docker stack ls
	docker stack deploy circle -c compose.yml
	docker stack services circle
	docker stack ps circle
	docker stack rm circle

---
### service
	> docker service create --replicas 2 --name nginx --publish 80:80  nginx

	升降实例数
	> docker service scale nginx=5
	
	### 回滚上版
	> docker service update --rollback nginx
	
	### 升降镜像
	> docker service update --image nginx:1.13.12 nginx
	
	### 
	> docker node update --availability drain nginx.1


