<!--
 * @Author: error: git config user.name && git config user.email & please set dead value or install git
 * @Date: 2022-08-24 10:09:30
 * @LastEditors: error: git config user.name && git config user.email & please set dead value or install git
 * @LastEditTime: 2022-08-25 11:06:22
 * @FilePath: \dial-vante:\vscode-work-space\pic\md\jenkins\jenkins.md
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
-->
<!--md的段落和段落之间必须空格一行，这样才会跳出上一个的格式 -->
<!--md的#相当于word文档中的标题 1个#通常用做整个文档的标题  后面依次  最多支持6个#  而且和文字必须间隔一个空格才会生效 -->
<!-- ``代码块可以完整的高亮显示任何代码以及脚本，当然也可以高亮任何标题：比如# 1. `项目使用` 自己已更改快捷键为，  tab+d -->
<!-- 注释语法 和html中的注释语法一样，在vscode中快捷键一样 -->
<!-- md超链接的语法是 [超链接的文字](链接地址)  ，如下-->
<!-- 我自己已更改Markdown All in One插件的快捷键 -->
<!-- rm -rf /install/jenkins_home -->
<!-- https://blog.csdn.net/wjh1840226173/article/details/124355167   OpenSSL SSL_read: Connection was reset, errno 10054的解决方法 -->
# Centos服务器部署Docker（20以上的新版本，才可以支持容器内部 
 
 的docker in docker的技术）

## 创建目录并且授予最高权限

 `mkdir -p /install/docker && chmod 777 /install/docker`
 


## 将以下链接的脚本下载下来，放在上一步在服务器创建的目录下面

[自动更新操作系统内核版本脚本,点击下载]( https://github.com/new-coder-fei/pic/blob/master/md/docker/install_before_docker_env.sh)
  

[自动安装docker环境脚本,点击下载](https://github.com/new-coder-fei/pic/blob/master/md/docker/install_docker-new.sh)


## 给脚本授予最高可执行权限（从windows丢上来的shell脚本都要授权一次，才能正常执行）

 `chmod 777 /install/docker/install_before_docker_env.sh  && chmod 777 /install/docker/install_docker-new.sh`


## 先执行install_before_docker_env.sh脚本，将服务器的操作系统内核更新到支持最新docker的环境

 `cd /install/docker/  &&  ./install_before_docker_env.sh`


其中有一步输yes或者no的时候选择输入yes，然后有可能到下图的时候这个时候会有点卡，可以ctrl+c退出来，再执行一遍install_before_docker_env.sh脚本命令，也是该输yes的时候输入yes，然后开始可能还是慢不用管，最多20分钟装好，装完会自动关机一次，稍等几分钟重连即可
 ![](https://new-coder-fei.github.io/pic/images/docker/1.png)

 

## 先执行iinstall_docker-new.sh脚本，安装docker

 `cd /install/docker/  &&  ./install_docker-new.sh`

到下图的时候，需要配置docker的国内镜像加速下载地址，复制内容 ` {"registry-mirrors": ["http://hub-mirror.c.163.com"]} `,到文件中，然后esc推出编辑模式，然后是shift+：号wq！保存文件，脚本继续自动执行完后曾

  ![](https://new-coder-fei.github.io/pic/images/docker/1.png)

  




 