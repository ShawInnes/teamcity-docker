#!/bin/sh

mkdir -p datadir/config
mkdir logs
mkdir mysqldata
mkdir agentconf

cp database.properties datadir/config

docker run -d --name teamcity-mysql \
    -v $PWD/mysqldata:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=mysqlsecret -d \
    -e MYSQL_DATABASE=teamcity \
    -e MYSQL_USER=teamcity \
    -e MYSQL_PASSWORD=teamcity \
    mysql

docker run -d --name teamcity-server-instance  \
    --link teamcity-mysql:mysql \
    -v $PWD/datadir:/data/teamcity_server/datadir \
    -v $PWD/logs:/opt/teamcity/logs  \
    -p 8111:8111 \
    jetbrains/teamcity-server

docker run -d --name teamcity-agent-1 \
    --link teamcity-server-instance:teamcity \
    -e SERVER_URL="http://teamcity:8111" \
    -v $PWD/agentconf:/data/teamcity_agent/conf  \
    jetbrains/teamcity-agent


