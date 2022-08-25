#其中 pro 目录就是vue在本地打包出来的一个目录，名字可以随便取
# 设置基础镜像
FROM nginx
# # 定义作者
# MAINTAINER kl
# 将当前Dockerfile文件同级的的pro文件夹复制到容器内部 /usr/share/nginx/html/pro 这个目录下面
#容器内部中如果这个目录不存在，会自动创建pro目录
 COPY wx-share  /usr/share/nginx/html/wx-share
# COPY dist  /usr/share/nginx/html/dist
#将当前Dockerfile文件同级的nginx.conf文件拷贝到容器内部的 /etc/nginx/nginx.conf
#如果没有会创建，如果有会覆盖
COPY nginx.conf /etc/nginx/nginx.conf
#输出一句话 表示完成
RUN echo 'echo init ok!!'

EXPOSE 80