#!/usr/bin/env bash
#安装docker脚本
echo '----安装docker准备开始----'

echo '----安装docker开始----'
#yum  install docker -y
curl -fsSL https://get.docker.com/ | sh
echo '----安装docker结束----'

echo '----查看docker版本开始----'
docker --version
echo '----查看docker版本结束----'


echo '----更改docker 国内镜像原版本开始----'

#mkdir docker
mkdir -p /etc/docker
chmod -R 777 /etc/docker
sudo vi /etc/docker/daemon.json
#{
#
#“registry-mirrors”: [“http://hub-mirror.c.163.com”]
#
#}
systemctl restart docker.service
echo '----更改docker 国内镜像原版本结束----'

echo '----设置docker 开机启动开始----'
systemctl start docker
systemctl enable docker
#这行不需要
#yum install -y yum-utils >   device-mapper-persistent-data >   lvm2
systemctl enable docker
echo '----设置docker 开机启动结束----'




echo '----安装docker准备结束----'


