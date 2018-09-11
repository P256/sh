# down
curl -O http://www.redmine.org/releases/redmine-3.3.1.tar.gz

#http://www.redmine.org/projects/redmine/wiki/RedmineInstall/
# mysql shell
# CREATE DATABASE redmine CHARACTER SET utf8;
# CREATE USER 'redmine'@'localhost' IDENTIFIED BY 'my_password';
# GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost';
# GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost' IDENTIFIED BY 'redmine101';

# down
curl -O https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.3.tar.gz
./configure --prefix=/usr/local/ruby
make
make install
# yum install ruby
# profile
echo 'export PATH="${PATH}:/usr/local/ruby/bin"' >> /etc/profile
#
gem sources -l
#
gem install rails
#
rails --version
# 
bundle install --without development test rmagick postgresql sqlite
# useradd -s /sbin/nologin -M -c "redmine" redmine
# chown -R redmine:redmine /data/redmine
#
rake generate_secret_token
# init
set RAILS_ENV=production
#
rake db:migrate
# import data <这里会设置默认语言>
rake redmine:load_default_data
# run
rails server webrick -e production