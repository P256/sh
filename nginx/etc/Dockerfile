# 镜像
FROM nginx
# 作者
MAINTAINER SUC168@qq.com
# 时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# 目录
RUN mkdir -p /var/log/nginx /var/www/html
# 主配
ADD *.conf /etc/nginx/
# 虚拟
ADD conf.d /etc/nginx/conf.d
# 端口
EXPOSE 80
# 守护
#CMD ["nginx", "-g", "daemon off;"]