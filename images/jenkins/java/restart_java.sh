#!/usr/bin/env bash




echo '----部署java开始----'
cd /install/wx/mall-api
docker stop mall-api
docker rm mall-api
docker rmi mall-api:latest-dev
docker build  -t mall-api:latest-dev .
#docker run -it -v /宿主机目录:/容器目录 镜像名 宿主机必须执行该命令 echo "Asia/shanghai" > /etc/timezone
docker run -d -p 30009:8080  --privileged=true -v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Shanghai  --name mall-api --restart always mall-api:latest-dev
echo '----部署java结束----'



#echo '----部署微信网页前端开始----'
#cd /install/wx/wx-share
#docker stop wx-share
#docker rm wx-share
#docker rmi wx-share:latest-dev
#docker build  -t wx-share:latest-dev .
#docker run -d -p 30006:80  --privileged=true -v /etc/localtime:/etc/localtime:ro -e TZ=Asia/Shanghai --name wx-share --restart always wx-share:latest-dev
#echo '----部署微信网页前端结束----'






