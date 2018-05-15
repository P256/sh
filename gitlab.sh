#!/usr/bin/bash
clear
#安装依赖包
sudo yum install curl policycoreutils openssh-server openssh-clients
sudo systemctl enable sshd
sudo systemctl start sshd
sudo yum install postfix
sudo systemctl enable postfix
sudo systemctl start postfix
#下载包
curl -O https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el7/gitlab-ce-8.8.3-ce.0.el7.x86_64.rpm
rpm -i gitlab-ce-8.8.3-ce.0.el7.x86_64.rpm
gitlab-ctl reconfigure
gitlab-ctl start

#https://github.com/larryli/gitlabhq/
#下载
curl -O http://192.168.100.83/packet/gitlab-rails.tar
tar -xvf gitlab-rails.tar
gitlab-ctl stop
cp -r /opt/gitlab/embedded/service/gitlab-rails /opt/gitlab/embedded/service/gitlab-rails-bakup
cp -fr gitlab-rails /opt/gitlab/embedded/service/gitlab-rails
gitlab-ctl start
gitlab-ctl reconfigure
