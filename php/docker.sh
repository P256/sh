# 
docker pull php:7.2-fpm


docker pull  redis:5.0


docker pull nginx






docker pull mysql:5.7
docker run -p 3306:3306 --name mysql -v $PWD/conf:/etc/mysql/conf.d -v $PWD/logs:/logs -v $PWD/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root101 -d mysql:5.7

docker exec -it 8936dec74edb /bin/bash
docker exec -it 8936dec74edb mysql -uroot -p

create DATABASE hnzz;

DROP DATABASE hnzz;


CREATE DATABASE hnzz DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

/data/php/www/hnzz.sql


/etc/mysql/conf.d/hnzz.sql


docker exec -it 8936dec74edb mysqldump -uroot -proot101 hnzz > /etc/mysql/conf.d/hnzz-1031.sql


docker run -p 6379:6379 -v $PWD/data:/data  -d redis:5.0 redis-server --appendonly yes

docker exec -it 24c59e2eb2c8 redis-cli
docker exec -it 24c59e2eb2c8 /bin/bash



docker run -p 9000:9000 --name php -v $PWD/www:/www -d php:7.2-fpm  --link mysql:mysql php

docker exec -it 72521f2cbf11 php -v

docker exec -it 72521f2cbf11 /bin/bash

docker-php-ext-install pdo_mysql

docker-php-ext-install gd 

docker-php-ext-install mysqli
172.18.0.3	php







mkdir conf www logs
docker run -d -p 80:80 --name nginx -v $PWD/www:/var/www -v $PWD/conf/nginx.conf:/etc/nginx/nginx.conf -v $PWD/conf/conf.d:/etc/nginx/conf.d -v $PWD/logs:/var/log/nginx --link php-fpm:php nginx

docker run -d -p 80:80 --name nginx -v $PWD/www:/var/www -v $PWD/conf/conf.d:/etc/nginx/conf.d -v $PWD/logs:/var/log/nginx --link php:php nginx


docker exec -it 774b7c284b19 /bin/bash

location /admin.php {
    rewrite "/admin.php/(.*)" "/admin.php?s=$1" last;
}

docker exec -it 774b7c284b19 nginx -s reload

 -v $PWD/conf/http.conf:/etc/nginx/http.conf 



 server {
    listen       80;
    server_name  localhost;

    charset utf-8;
    #access_log  /var/log/nginx/host.access.log  main;

    location / {
        root   /var/www;
        index  index.html index.htm;
        if (!-e $request_filename){
            rewrite  ^(.*)$  /index.php?s=$1  last;   break;
        }
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    location ~ \.php$ {
       fastcgi_pass   php:9000;
       fastcgi_index  index.php;
       fastcgi_param  SCRIPT_FILENAME  /www$fastcgi_script_name;
       include        fastcgi_params;
    }

    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    #location ~ /\.ht {
    #    deny  all;
    #}
}