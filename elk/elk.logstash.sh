#!/usr/bin/bash
clear
# 设置资源来源
sourceUrl="http://192.168.100.83/packet"
cd /usr/local/src
echo "###############################################################################"
# 设置安装路径
filePath=/usr/local/logstash
echo "Install logstash"
curl -O ${sourceUrl}/logstash-2.3.2.tar.gz
tar -zxvf logstash-2.3.2.tar.gz
mv logstash-2.3.2 ${filePath}
mkdir -p ${filePath}/conf
echo "Install logstash finish"
echo "###############################################################################"
# 插件列表<https://github.com/logstash-plugins>
# 默认支持很多插件
logstash-plugin list
# 配置环境变量
sed -i '$a LOGSTASH_HOME='${filePath}/bin /etc/profile
source /etc/profile
# 创建配置文件
vi ${filePath}/conf/indexer.conf
# see https://www.elastic.co/guide/en/logstash/2.3/plugins-inputs-http.html
input {
	# 输入接收数据
    stdin { }
	
	# 从redis接收数据
	redis { 
        host      => "10.140.45.190"    # redis主机地址
        port      => 6379               # redis端口号
        db        => 8                  # redis数据库编号
        data_type => "channel"          # 使用发布/订阅模式
        key       => "logstash_list_0"  # 发布通道名称
    }
	
	# 从本地文件接收数据
    file {
        path => [
			# 这里填写需要监控的文件
			"/var/log/messages",
			"/var/log/dmesg",
			"/var/log/*.log"
        ]
        type => "system"
    }
	
	# 从jdbc获取数据
	jdbc {
		schedule=>"0 0-59 0-23 ? * *"
		jdbc_driver_library => "mysql-connector-java-5.1.39-bin.jar"
		jdbc_driver_class => "com.mysql.jdbc.Driver"
		jdbc_connection_string => "jdbc:mysql://192.168.100.240:3306/data"
		jdbc_user => "sync"
		jdbc_password => "sync"
		statement => "SELECT * from user"
		#statement_filepath => "jdbc.sql"
		jdbc_paging_enabled => "true"
		jdbc_page_size => "50000"
	}
	
	# 系统log
	syslog {
		port => "514"
	}
	
	# 还有很多可以支持
}
filter {
	# Json
    json {
        source => "message"
        remove_field => ["message"]
    }
	
	# 地理位置
	geoip {
        source => "message"
    }
	
	# 正则表达式
	grok {
        match => ["message", "%{HTTPDATE:logdate}"]
    }
	
	# 时间
    date {
        match => ["logdate", "dd/MMM/yyyy:HH:mm:ss Z"]
    }
	
	# 还有很多可以支持
}
output {
    # 输出到控制台
    stdout { }

    # 输出到redis
    redis {
        host => "10.140.45.190"   # redis主机地址
        port => 6379              # redis端口号
        db => 8                   # redis数据库编号
        data_type => "channel"    # 使用发布/订阅模式
        key => "logstash_list_0"  # 发布通道名称
    }
	
	# 输出到本地文件
	file { 
        path           => "/data/log/logstash/all.log" # 指定写入文件路径
        message_format => "%{host} %{message}"         # 指定写入格式
        flush_interval => 0                            # 指定刷新间隔，0代表实时写入
    }

	# 输出到es
	elasticsearch {
        hosts 			=> ["192.168.100.220"]
        index 			=> "logstash-demo-%{+YYYY.MM.dd}"
        document_id 	=> "%{id}"
		document_type 	=> "user"
		workers 		=> 5
        template_overwrite => true
    }

	# 还有很多可以支持
}

# 在Indexer主机上启动
logstash agent -f indexer.conf
#logstash -e 'input{stdin{}}output{stdout{codec=>rubydebug}}'
#demo
#logstash agent --verbose --config /usr/local/logstash/conf/jdbc-mysql.conf --log /data/log/logstash/stdo
#logstash -f jdbc-mysql.conf

--log logs/stdout &
nohup /usr/local/logstash-1.4.3/bin/logstash agent -f indexer.conf &>/dev/null &