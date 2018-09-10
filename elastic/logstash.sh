#
curl -O https://artifacts.elastic.co/downloads/logstash/logstash-6.4.0.tar.gz
#
tar zxvf logstash-6.4.0.tar.gz
#
mv logstash-6.4.0 ../logstash
#
mv ../logstash/config/logstash-sample.conf ../logstash/config/logstash.conf
#
../logstash/bin/logstash -f logstash.conf

#######################################################################################
# jvm.options
#######################################################################################
-Xms128m
-Xmx128m

#######################################################################################
# logstash.yml
#######################################################################################
input {
	# 以文件作为来源
	file {
		# 日志文件路径
		path => "F:\test\dp.log"
	}
}
filter {
	# 定义数据的格式，正则解析日志（根据实际需要对日志日志过滤、收集）
	grok {
	    match => {
	    	"message" => "%{IPV4:clientIP}|%{GREEDYDATA:request}|%{NUMBER:duration}"
	    }
	}
	# 根据需要对数据的类型转换
	mutate {
		convert => { "duration" => "integer" }
	}
}
# 定义输出
output {
	elasticsearch {
		hosts => ["localhost:9200"] #Elasticsearch 默认端口
	}
}　
#######################################################################################
