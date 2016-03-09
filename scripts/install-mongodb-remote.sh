#!/bin/bash

set -e
sudo mkdir -p /var/lib/mongodb

sudo docker pull daocloud.io/mongo:latest
set +e
sudo docker rm -f mongodb
set -e

sudo docker run \
  -d \
  --restart=always \
  -p 27017:27017 \
  --volume=/var/lib/mongodb:/data/db \
  --name=mongodb \
  mongo mongod
