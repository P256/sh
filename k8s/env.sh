!/bin/bash
clear

# 设置hosts
cat >>/etc/hosts<<EOF
192.168.1.2 master
192.168.1.2 etcd
192.168.1.3 node1
EOF

# 配置YUM源
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes Repository
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
EOF

# 虚拟内存 (永久禁掉： vi /etc/fstab 注释掉swap那一行)
swapoff -a

# 生效
sysctl -p