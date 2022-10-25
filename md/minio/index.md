# minio搭建私有化oss对象存储服务 

## minio 使用docker搭建

`docker run    --name minio  -d --privileged=true -v /etc/localtime:/etc/localtime  --restart=always  -e TZ=“Asia/Shanghai   -p 50008:9000   -p 50009:9001    -v /install/minio/data:/data  -e "MINIO_ROOT_USER=AKIAIOSFODNN7EXAMPLE"  -e "MINIO_ROOT_PASSWORD=123/456/789"   quay.io/minio/minio server /data --console-address ":9001"`

如果在docker run的时候不加上设置账号和密码的参数的时候，minio会有一个默认的账号密码，最好指定，这样方便记忆

## 存储桶的概念，以及命令规则

存储桶实际上可以理解成一个独立的空间，可以通过存储桶-dev等后缀来划分开发环境来使用，所以一个minio服务可以同时为很多项目提供单独的空间存储
存储桶名称必须以小写字母或数字开头,不得包含大写字符或下划线,称长度必须至少为3且不超过63个字符