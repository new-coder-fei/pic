# 该镜像需要依赖的基础镜像
FROM java:8
VOLUME /tmp
# 将当前目录下的jar包复制到docker容器的/目录下
#ADD mall-tiny-docker-file-0.0.1-SNAPSHOT.jar /mall-tiny-docker-file.jar
# 将当前目录下的jar包复制到docker容器的/目录下
ADD mall-api-1.0.0-SNAPSHOT.jar /mall-api-1.0.0-SNAPSHOT.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/mall-api-1.0.0-SNAPSHOT.jar"]
##thymeleaf-master表示生成镜像的名称，（注意后面有个点.,而且镜像名最好不要有什么特殊符号） #docker build -t lys .
#这里我项目用的8082端口，这里我也映射8082端口，加上--name xxx是为了给容器取别名，方便docker命令操作
#docker run -d -p 7777:7777 --name lys lys:latest
EXPOSE 8080
