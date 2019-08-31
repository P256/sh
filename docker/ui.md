---
# docker-ui

> docker run -it -d --name docker-ui -p 6060:9000 -v /var/run/docker.sock:/var/run/docker.sock uifd/ui-for-docker

--- 
# rancher-ui

> docker run -d --name rancher-ui --restart=always -p 6060:8080 rancher/server

--- 
# portainer-ui

> docker run -d --name portainer-ui -p 6060:9000 portainer/portainer

--- 
# dockerswarm-ui

> docker run -d -p 6060:3000 -v /var/run/docker.sock:/var/run/docker.sock --name dockerswarm-ui mlabouardy/dockerswarm-ui

# shipyard-ui

> docker run -it -d --name rethinkdb-data --entrypoint /bin/bash shipyard/rethinkdb -l

> docker run -it -P -d --name shipyard-rethinkdb --volumes-from rethinkdb-data shipyard/rethinkdb

> docker run -it -p 6060:8080 -d --name shipyard --link shipyard-rethinkdb:rethinkdb shipyard/shipyard


