#!/usr/bin/bash
clear
# install dependencies
sudo yum install curl policycoreutils openssh-server openssh-clients
sudo systemctl enable sshd
sudo systemctl start sshd

sudo firewall-cmd --permanent --add-service=http
sudo systemctl reload firewalld

# install Postfix
sudo yum install postfix
sudo systemctl enable postfix
sudo systemctl start postfix

# Add the GitLab package repository 
#curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | sudo bash

# install the package
#sudo yum install gitlab-ce

# rpm install package
cat /etc/redhat-release
# 
sudo curl -O https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el7/gitlab-ce-10.3.5-ce.0.el7.x86_64.rpm
# 
sudo rpm -ivh gitlab-ce-10.3.5-ce.0.el7.x86_64.rpm

# 3. Æô¶¯GitLab
sudo gitlab-ctl reconfigure

sudo gitlab-ctl start