
## 下载
	curl -L https://github.com/docker/machine/releases/download/v0.13.0/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine
	chmod +x /usr/local/bin/docker-machine


## 常用命令
	docker-machine create	创建一个 Docker 主机（常用-d virtualbox）
	docker-machine ls		查看所有的 Docker 主机
	docker-machine ssh		SSH 到主机上执行命令
	docker-machine env		显示连接到某个主机需要的环境变量
	docker-machine inspect	输出主机更多信息
	docker-machine kill		停止某个主机
	docker-machine restart	重启某台主机
	docker-machine rm		删除某台主机
	docker-machine scp		在主机之间复制文件
	docker-machine status	查看主机状态
	docker-machine stop		停止一个主机
	docker-machine start	启动一个主机






---
### 随笔

> docker-machine create -d virtualbox manager1

> docker-machine ls


## 远程工具
> docker-machine ssh manager1

