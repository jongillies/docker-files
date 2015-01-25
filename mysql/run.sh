#!/bin/bash

docker run --name some-mysql -p 33066:3306 -e MYSQL_ROOT_PASSWORD=password -d mysql
docker exec -it some-mysql mysqladmin -u root -ppassword password ""
docker exec -it some-mysql mysql -u root -e "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY '' WITH GRANT OPTION; FLUSH PRIVILEGES" 

