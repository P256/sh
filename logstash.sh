#
curl -O　https://artifacts.elastic.co/downloads/logstash/logstash-6.4.0.tar.gz
#
tar zxvf logstash-6.4.0.tar.gz
#
mv logstash-6.4.0 ../logstash
#
../logstash/bin/logstash -f logstash.conf



