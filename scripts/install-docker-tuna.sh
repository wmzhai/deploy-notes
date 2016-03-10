#!/bin/bash

# 查看docker是否已经安装
set +e  # 如果一个指令返回非零状态，仍然继续运行，因为下面这个语句可能会错
haveDocker=$(docker version | grep "version")
set -e  # 如果一个指令返回非零状态，则退出

if [ ! "$haveDocker" ]; then

  # Remove the lock
  set +e
  sudo rm /var/lib/dpkg/lock > /dev/null
  sudo rm /var/cache/apt/archives/lock > /dev/null
  sudo dpkg --configure -a
  set -e

  # Add TUNA Mirror
  sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  echo "deb https://mirrors.tuna.tsinghua.edu.cn/docker/apt/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list

  # Required to update system
  sudo apt-get update

  # Install docker
  sudo apt-get install docker-engine -y
fi
