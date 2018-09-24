# k8s指令

## 查看版本
- kubectl version

# 集群
#####################################################################

## 显示集群
- kubectl cluster-info

## 集群节点
- kubectl get nodes

## 节点详情
kubectl describe node 127.0.0.1

## 运行镜像
- kubectl run nginx01 --image=nginx --replicas=2 --port=80

## 查看pod
- kubectl get pods

## 查看服务详情信息
- kubectl describe pod nginx01-379829228-cwlbb

## 删除pod
- kubectl delete pod nginx01-379829228-cwlbb

## 再次查看pod，发现由于replicas机制，pod又生成一个新的
- kubectl get pods


## 查看空间
kubectl get namespaces

以下命令将上一步骤中的nginx容器连接到公网中：

- kubectl expose rc nginx --port=80 --type=LoadBalancer




### 部署
#####################################################################

## 部署服务
- kubectl run nginx --image=nginx --replicas=2 --port=80

## 查看部署
- kubectl get deployments

## 删除部署
- kubectl delete deployment nginx

#####################################################################

## rc
kubectl create -f nginx-rc.yaml

## 查看rc
kubectl get rc

## del
kubectl delete -f nginx-rc.yaml

#####################################################################

## service
kubectl create -f nginx-service.yaml --record

## 查看service
kubectl get service

## service
kubectl describe service nginx

## del
kubectl delete -f nginx-service.yaml

