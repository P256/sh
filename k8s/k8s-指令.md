# k8s指令

## 查看版本
- kubectl version

## 显示集群
- kubectl cluster-info

## 集群节点
- kubectl get nodes

## 运行镜像
- kubectl run nginx01 --image=nginx --replicas=2 --port=80

## 查看pod
- kubectl  get pods

## 查看服务详情信息
- kubectl  describe pod nginx01-379829228-cwlbb

## 查看已部署
- kubectl  get deployments

## 删除pod
- kubectl delete pod nginx01-379829228-cwlbb

## 再次查看pod，发现由于replicas机制，pod又生成一个新的
- kubectl  get pods

## 删除部署的my-nginx服务。彻底删除pod
- kubectl delete deployment nginx


