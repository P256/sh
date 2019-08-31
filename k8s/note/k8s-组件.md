# k8s组件

- kubeadm: 用来初始化集群的指令

- kubelet: 在集群中的每个节点上用来启动 pod 和 container 等

- kubectl: 客户端集群通信的命令行工具,格式化后发送给kube-apiserver;作为整个系统的操作入口;

- 1.kubectl: 集群通信的命令行工具
	作为整个系统的操作入口 => 发送给kube-apiserver

- 2.kube-apiserver
	作为整个系统的控制入口 => 以REST API服务提供接口

- 3.kube-controller-manager
	用来执行整个系统中的后台任务
	包括节点状态状况、Pod个数、Pods和Service的关联等

- 4.kube-scheduler
	负责节点资源管理
	接受来自kube-apiserver创建Pods任务,并分配到某个节点

- 5.etcd
	节点间服务发现和配置共享

- 6.kube-proxy
	计算节点上 Pod网络代理定时从etcd获取到service信息来做相应的策略

- 7.kubelet
	运行在每个计算节点上
	作为agent
	接受分配该节点的Pods任务及管理容器
	周期性获取容器状态
	反馈给kube-apiserver

- 8.DNS
	一个可选的DNS服务
	用于为每个Service对象创建DNS记录
	这样所有的Pod就可以通过DNS访问服务了

