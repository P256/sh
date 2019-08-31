ssh 免密码登录

说明：

ssh 无密码登录要使用公钥与私钥。

linux或者mac系统下可以用用ssh-keygen生成公钥/私钥对。

## 1.在本机生成密钥(~/.ssh目录下生成id_rsa和id_rsa.pub
	
### ssh-keygen -t rsa

## 2.发送公钥到远程主机 ~/ 目录下

### scp  ~/.ssh/id_rsa.pub root@192.168.0.0:~/

## 3.登录远程主机把公钥追加到授权key中

### cat ~/id_rsa.pub >> ~/.ssh/authorized_keys （赋予600权限  chmod 600 authorized_keys）

## 4.现在你就能正常登录了

### ssh root@192.168.0.0

## 5.为了简化登录操作
### vim ~/.bashrc，添加以下行：alias sshlogin = "ssh root@192.168.0.0"
 
### source  ～/.bashrc
## 6.然后就可以更简便的登陆了
### sshlogin