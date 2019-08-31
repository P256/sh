### 参考
	https://blog.csdn.net/xiaochendefendoushi/article/details/80979905

---

### 下载
	curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose

---
### 随笔

### 创建并启动容器
> docker-compose -f nginx.yml up

### 后台启动服务容器 
> docker-compose up -d

### 启动所有已经存在的服务容器 
> docker-compose start

### 停止所有已经处于运行状态的容器 
> docker-compose stop

### 重启所有已经存在的容器 
> docker-compose restart

### 启动 / 停止 / 重启 指定 (例如 php) 服务容器 
> docker-compose start/stop/restart php

### 删除所有 (停止状态的) 服务容器 
> docker-compose rm

### 强制删除所有服务容器 
> docker-compose rm -f

### 验证 Compose 文件格式是否正确 
> docker-compose config

