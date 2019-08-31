# 
composer install
# env
cp .env.example .env
# app key
php artisan key:generate
# 创建上传目录软链接
php artisan storage:link
# 设置目录权限
chmod -R  0777 storage
# 安装数据表
php artisan migrate
# 调试数据库
php artisan tinker


