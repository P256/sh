#!/usr/bin/bash
clear
cd /usr/local/src
esjdbc=/usr/local/esjdbc
echo "###############################################################################"
echo "Install esjdbc"
#http://xbib.org/repository/org/xbib/elasticsearch/importer/elasticsearch-jdbc/2.3.3.0/
curl -O http://192.168.100.83/packet/elasticsearch-jdbc-2.3.3.0.tar
tar -xvf elasticsearch-jdbc-2.3.3.0.tar
mv elasticsearch-jdbc-2.3.3.0 ${esjdbc}
cd ../
echo "###############################################################################"
echo "Sync mysql data"
bin=${esjdbc}/bin
lib=${esjdbc}/lib

echo '
{
    "type" : "jdbc",
    "jdbc" : {
        "url" : "jdbc:mysql://192.168.100.240:3306/demo",
        "user" : "sync",
        "password" : "sync",
        "sql" : "SELECT * FROM user;",
        "index" : "demo",
        "type" : "user",
		"metrics": {
            "enabled" : true
        },
        "elasticsearch" : {
             "cluster" : "demo",
             "host" : "192.168.100.62",
             "port" : 9300 
        }
    }
}
' | java \
    -cp "${lib}/*" \
    -Dlog4j.configurationFile=${bin}/log4j2.xml \
    org.xbib.tools.Runner \
    org.xbib.tools.JDBCImporter
