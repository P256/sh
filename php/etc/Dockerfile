# 镜像
FROM php:7.1.26-fpm
# 作者
MAINTAINER Suc168@qq.com
# 时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# 扩展
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN docker-php-ext-install pdo_mysql
# 主配
ADD php.ini /usr/local/etc/php
# 端口
EXPOSE 9000