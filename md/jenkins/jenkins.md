<!--
 * @Author: error: git config user.name && git config user.email & please set dead value or install git
 * @Date: 2022-08-24 10:09:30
 * @LastEditors: error: git config user.name && git config user.email & please set dead value or install git
 * @LastEditTime: 2022-08-24 18:22:45
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

# docker+jenkins+maven+springboot+vue 前后端自动化环境搭建第一章

### 搭建 jenkins 服务

#### 创建需要的目录

##### `mkdir -p /install/jenkins_home`

#### 授予最高权限，避免一些权限问题

##### `chmod -R 777 /install/jenkins_home`

#### 运行服务

##### `docker run -d --name jenkins -uroot -p 50001:8080 -p 50000:50000 --restart=always -e TZ=“Asia/Shanghai” -e JENKINS_OPTS="--prefix=/jenkins" -e JENKINS_ARGS="--prefix=/jenkins" --privileged=true -v /install/jenkins_home:/var/jenkins_home -v /etc/localtime:/etc/localtime jenkins/jenkins:latest`

---

·

#### 命令详细解释：

docker run
-d #表示后台运行 （所有 docker 容器基本必须加的参数）
--name jenkins #表示该容器的名称，必须是唯一·的值，不能重复，可以用它他来代替容器 id，更容易记忆，就类似于域名和 IP 的关系，用它可以代替容器 ID 删除，或者停止容器服务

--restart always #能够使我们在重启 docker 时，自动启动相关容器 （所有 docker 容器基本必须加的参数）

-p 50001:8080 #用宿主机的 50001 端口映射容器内部服务的 8080 端口（jenkins 服务的 web 界面服务端口，50001 可以换成任意宿主机开放的端口，-p 50000:50000 这个默认的不用改）

-e TZ=“Asia/Shanghai” #设置 jenkins 服务的的时区参数保证和宿主机时间一致

-v /etc/localtime:/etc/localtime #设置 jenkins 服务的的时区参数保证和宿主机时间一致

-e JENKINS_OPTS="--prefix=/jenkins" -e JENKINS_ARGS="--prefix=/jenkins" #设置 jenkins 服务的访问项目名，如果后面要用到 nginx 代理 ip 端口进项访问，那么这个必须要设置

-v /install/jenkins_home:/var/jenkins_home #将 jenkins 服务/var/jenkins_home 的文件以及目录持久化到宿主机的/install/jenkins_home，可以便于我们对某些文件的操作，以及上传一些文件到容器内部使用

--privileged=true #权限 ，给容器赋予最高权限 （所有 docker 容器基本必须加的参数，会减少很多不必要的权限错误）

jenkins/jenkins:latest # 指定镜像的版本 格式：仓库地址/镜像项名称:镜像版本号 latest 表示最新的版本号 ，如果没有提前拉去镜像，则会自动拉取（所有 docker 容器基本必须加的参数）

---

#### 验证是否搭建成功：

1. 访问 http://宿主机 IP:50001/jenkins/,出现以下界面即运行成功

![](https://new-coder-fei.github.io/pic/images/jenkins/2.png)

2. 在宿主机执行 `cat /install/jenkins_home/secrets/initialAdminPassword` ,获取初始登录密码

![](https://new-coder-fei.github.io/pic/images/jenkins/4.png)

3.  选择点击安装推荐的插件，耐心等待所有插件安装完成

![](https://new-coder-fei.github.io/pic/images/jenkins/5.png)
![](https://new-coder-fei.github.io/pic/images/jenkins/6.png)

4.  注册一个非admin的用户，后面可以用该用户登录操作jenkins，拥有和admin用户的一样的权限，保存完成，开始使用jenkins

![](https://new-coder-fei.github.io/pic/images/jenkins/7.png)
![](https://new-coder-fei.github.io/pic/images/jenkins/8.png)
![](https://new-coder-fei.github.io/pic/images/jenkins/9.png)

5.  安装jenkins中文插件

![](https://new-coder-fei.github.io/pic/images/jenkins/10.png)
![](https://new-coder-fei.github.io/pic/images/jenkins/11.png)
![](https://new-coder-fei.github.io/pic/images/jenkins/12.png)

6. 在宿主机执行 `docker restart jenkins` 重启jenkins，加载最新的插件，此时回到web界面应该都是中文显示了

![](https://new-coder-fei.github.io/pic/images/jenkins/13.png)
![](https://new-coder-fei.github.io/pic/images/jenkins/14.png)





#### 安装jdk环境

##### 自动安装jdk，但是这种方案感觉不太稳定，容易出错

![](https://new-coder-fei.github.io/pic/images/jenkins/15.png)


#####  手动安装jdk，这种方式不论是容器部署的jenkins还是物理机装的jenkins都很稳定，不易出错



###### 下载linux版本的jdk11(jenkins2.357版本以后只支持jdk11及以上，jdk1.8会报错)，下载地址 华为镜像云地址： https://repo.huaweicloud.com/java/jdk/11.0.2+9/

![](https://new-coder-fei.github.io/pic/images/jenkins/16.png)

###### 在jenkins容器的宿主机挂载目录下面创建java目录，不同版本的jdk都已安装在下面

`mkdir -p /install/jenkins_home/java`

###### 授予最高权限，避免一些权限问题

`chmod -R 777 /install/jenkins_home/java`

###### 利用xftp等工具将下载的jdk11的安装包上传至宿主机`/install/jenkins_home/java` 目录下面，这时候相应的容器内部 `/var/jenkins_home/java` 目录下面也有该jdk安装包了

![](https://new-coder-fei.github.io/pic/images/jenkins/17.png)

###### 利用xshell等linux终端工具， 执行`docker exec -it jenkins /bin/bash`进入容器内部命令行，在内部命令中再执行`cd /var/jenkins_home/java/`==》 `ls` ，查看该jdk安装包是否存在

![](https://new-coder-fei.github.io/pic/images/jenkins/18.png)


![](https://new-coder-fei.github.io/pic/images/jenkins/19.png)


###### 在当前`/var/jenkins_home/java/`目录下面执行  `tar -zxvf jdk-11.0.2_linux-x64_bin.tar.gz`  解压安装到当前目录

![](https://new-coder-fei.github.io/pic/images/jenkins/20.png)

###### 在容器命令行执行`exit`退出容器返回宿主机命令行，执行  `docker cp jenkins:/etc/profile  /install/jenkins_home/java` ,将容器内部的环境配置文件拷贝到宿主机进行操作（因为容器内部默认是没有vi或者vim命令的，不支持修改，不嫌麻烦可以在容器内部安装vi或者vi工具）,在执行 `vim /install/jenkins_home/java/profile` ，复制下面内容到文件最后一行，保存退出，在执行 `docker cp /install/jenkins_home/java/profile  jenkins:/etc/profile` 覆盖容器中的环境配置文件，再执行 `docker restart jenkins`，执行`docker exec -it jenkins /bin/bash`进入容器内部命令行,执行 `source /etc/profile`使得配置立即生效,最后执行  `java -version` ,出现下面截图内容即表示生效
`export JAVA_HOME=/var/jenkins_home/java/jdk-11.0.2
export CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$PATH:$JAVA_HOME/bin`

![](https://new-coder-fei.github.io/pic/images/jenkins/21.png)

###### 在jenkins的web管理界面，系统管理==》全局工具配置==》JDK==》新增jdk==》取消勾选自动安装==》别名填写 `jdk-11.0.2`，JAVA_HOME填写 `/var/jenkins_home/java/jdk-11.0.2`,点击下方的保存即可完成配置，如下图所示

![](https://new-coder-fei.github.io/pic/images/jenkins/22.png)





#### 安装maven环境

##### 和jdk一样，放弃jenkins的自动安装 

###### 下载linux版本的maven3.6.3(这个版本比较稳定)，下载地址 华为镜像云地址： https://repo.huaweicloud.com/apache/maven/maven-3/3.6.3/binaries/

![](https://new-coder-fei.github.io/pic/images/jenkins/23.png)

###### 在jenkins容器的宿主机挂载目录下面创建maven目录，不同版本的maven都可以安装在下面

`mkdir -p /install/jenkins_home/maven`

###### 授予最高权限，避免一些权限问题

`chmod -R 777 /install/jenkins_home/maven`

###### 利用xftp等工具将下载的maven的安装包上传至宿主机`/install/jenkins_home/maven` 目录下面，这时候相应的容器内部 `/var/jenkins_home/maven` 目录下面也有该maven安装包了

![](https://new-coder-fei.github.io/pic/images/jenkins/24.png)

###### 利用xshell等linux终端工具， 执行`docker exec -it jenkins /bin/bash`进入容器内部命令行，在内部命令中再执行`ls /var/jenkins_home/maven/` ，查看该安装包是否存在

![](https://new-coder-fei.github.io/pic/images/jenkins/25.png)


###### 在切换到 `cd /var/jenkins_home/maven/`目录下面执行  `tar -zxvf apache-maven-3.6.3-bin.tar.gz`  解压安装到当前目录


###### 在容器命令行执行`exit`退出容器返回宿主机命令行，执行  `docker cp jenkins:/etc/profile  /install/jenkins_home/maven` ,将容器内部的环境配置文件拷贝到宿主机进行操作（因为容器内部默认是没有vi或者vim命令的，不支持修改，不嫌麻烦可以在容器内部安装vi或者vi工具）,在执行 `vim /install/jenkins_home/maven/profile` ，复制下面内容到文件最后一行(并且需要把用下面的path来替换之前安装jdk时候的path)，保存退出，在执行 `docker cp /install/jenkins_home/maven/profile  jenkins:/etc/profile` 覆盖容器中的环境配置文件，再执行 `docker restart jenkins`，执行`docker exec -it jenkins /bin/bash`进入容器内部命令行,执行 `source /etc/profile`使得配置立即生效,最后执行  `mvn -version` ,出现下面截图内容即表示生效

`export MAVEN_HOME=/usr/local/apache-maven-3.6.3
export PATH=$MAVEN_HOME/bin:$JAVA_HOME/bin:$PATH`

![](https://new-coder-fei.github.io/pic/images/jenkins/26.png)



###### 在jenkins的web管理界面，系统管理==》全局工具配置==》Maven==》新增Maven==》取消勾选自动安装==》别名填写 `apache-maven-3.6.3`，MAVEN_HOME填写 `/var/jenkins_home/maven/apache-maven-3.6.3`,点击下方的保存即可完成配置，如下图所示

![](https://new-coder-fei.github.io/pic/images/jenkins/27.png)


###### 配置maven的国内镜像的setting.xml，[查看获取xml详细配置](https://new-coder-fei.github.io/pic/images/jenkins/settings.xml),将获取到的setting.xml上传到宿主机 `/install/jenkins_home/maven` 目录下面，相应容器内部的`/var/jenkins_home/maven/`中也会同步该文件， 在jenkins的web管理界面，系统管理==》全局工具配置==》Maven 配置==》按照下图配置即可，点击下方的保存即可完成配置，如下图所示，至此maven安装完成

![](https://new-coder-fei.github.io/pic/images/jenkins/28.png)



#### 安装前端Node环境

##### 下载node.js的jenkins插件，按照下图操作

![](https://new-coder-fei.github.io/pic/images/jenkins/29.png)
![](https://new-coder-fei.github.io/pic/images/jenkins/30.png)


##### 配置全局node.js的版本，建议 如果是最好用node14.17.2这个版本，这个版本适合vue2，vue3，react都可以打包，当然你也可以根据你自己的项目来决定，也可以像jdk一样多装几个，如下图配置，点击下方的保存即可完成配置

![](https://new-coder-fei.github.io/pic/images/jenkins/31.png)
