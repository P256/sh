# k8s角色

- 1.Pod
	在Kubernetes系统中，调度的最小颗粒不是单纯的容器，而是抽象成一个Pod，Pod是一个可以被创建、销毁、调度、管理的最小的部署单元。
	比如一个或一组容器。
	Pod是kubernetes的最小操作单元，一个Pod可以由一个或多个容器组成；
	同一个Pod只能运行在同一个主机上，共享相同的volumes、network、namespace；
  

- 2.ReplicationController（RC）
	RC用来管理Pod，一个RC可以由一个或多个Pod组成，在RC被创建后，系统会根据定义好的副本数来创建Pod数量。
	在运行过程中，如果Pod数量小于定义的，就会重启停止的或重新分配Pod，反之则杀死多余的。
	当然，也可以动态伸缩运行的Pods规模或熟悉。
	RC通过label关联对应的Pods，在滚动升级中，RC采用一个一个替换要更新的整个Pods中的Pod。
  
	Replication Controller是Kubernetes系统中最有用的功能，实现复制多个Pod副本，往往一个应用需要多个Pod来支撑，并且可以保证其复制的副本数，即使副本所调度分配的宿主机出现异常，通过Replication Controller可以保证在其它主宿机启用同等数量的Pod。
	Replication Controller可以通过repcon模板来创建多个Pod副本，同样也可以直接复制已存在Pod，需要通过Label selector来关联。
  
- 3.Service
	Service定义了一个Pod逻辑集合的抽象资源，Pod集合中的容器提供相同的功能。
	集合根据定义的Label和selector完成，当创建一个Service后，会分配一个Cluster IP，这个IP与定义的端口提供这个集合一个统一的访问接口，并且实现负载均衡。
  
	Services是Kubernetes最外围的单元，通过虚拟一个访问IP及服务端口，可以访问我们定义好的Pod资源，目前的版本是通过iptables的nat转发来实现，转发的目标端口为Kube_proxy生成的随机端口，目前只提供GOOGLE云上的访问调度，如GCE。
   
4）Label
	Label是用于区分Pod、Service、RC的key/value键值对；仅使用在Pod、Service、Replication Controller之间的关系识别，但对这些单元本身进行操作时得使用name标签。
	Pod、Service、RC可以有多个label，但是每个label的key只能对应一个；
	主要是将Service的请求通过lable转发给后端提供服务的Pod集合；
  


	说说个人一点看法，目前Kubernetes保持一周一小版本、一个月一大版本的节奏，迭代速度极快，同时也带来了不同版本操作方法的差异，另外官网文档更新速度相对滞后及欠缺，
	给初学者带来一定挑战。在上游接入层官方侧重点还放在GCE（Google Compute Engine）的对接优化，针对个人私有云还未推出一套可行的接入解决方案。

	在v0.5版本中才引用service代理转发的机制，且是通过iptables来实现，在高并发下性能令人担忧。但作者依然看好Kubernetes未来的发展，至少目前还未看到另外一个成体系、具备良好生态圈的平台，相信在V1.0时就会具备生产环境的服务支撑能力。
