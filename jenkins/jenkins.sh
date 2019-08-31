!/usr/bin/bash
##############################
# 构建持续集成系统 <Jenkins>##
# https://jenkins.io #########
##############################
clear
#source res.sh
######################################################################################################
echo "2.设置jenkins目录"
jenkinsPath=/usr/local/jenkins
# 创建目录
mkdir ${jenkinsPath}
######################################################################################################
echo "3.进入源码目录"
# 进入源码目录
cd /usr/local/src
# 设置文件名

# 下载Jar包
curl -O https://mirrors.tuna.tsinghua.edu.cn/jenkins/war/2.62/jenkins.war
#

# war包放入tomcat中或执行一下命令
#java -jar jenkins.war

# 访问http://localhost:8080 选择安装



