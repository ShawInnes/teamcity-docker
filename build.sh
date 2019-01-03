#!/bin/sh

VERSION="8.0.13"

mkdir -p jdbc
wget -c -O "jdbc/mysql-connector-java-$VERSION.tar.gz" "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$VERSION.tar.gz"

pushd jdbc
tar zxvf "mysql-connector-java-$VERSION.tar.gz"
popd

