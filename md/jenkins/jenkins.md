<!--md的段落和段落之间必须空格一行，这样才会跳出上一个的格式 -->
<!--md的#相当于word文档中的标题 1个#通常用做整个文档的标题  后面依次  最多支持6个#  而且和文字必须间隔一个空格才会生效 -->
<!-- ``代码块可以完整的高亮显示任何代码以及脚本，当然也可以高亮任何标题：比如# 1. `项目使用` 自己已更改快捷键为，  tab+d -->
<!-- 注释语法 和html中的注释语法一样，在vscode中快捷键一样 -->
<!-- md超链接的语法是 [超链接的文字](链接地址)  ，如下-->
<!-- 我自己已更改Markdown All in One插件的快捷键 -->
<!-- rm -rf /install/jenkins_home -->

# docker+jenkins+maven+springboot 自动化部署实战记录

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

3.  选择点击安装推荐的插件
4.  
![](https://new-coder-fei.github.io/pic/images/jenkins/5.png)
     

###### 修改方式有多种：

###### `1.可以找到对应目录的文件用xftp下载到本地进行修改再传上去`

###### `2.还可以直接在宿主机利用vi命令去修改`

###### `3.还可以直接linux的替换命令 sed直接替换（前面两种都需要人为介入修改，自动化程度不高，建议直接用sed，这样可以交给脚本完成）`

将 gitlab.rb 中的 external_url 'GENERATED_EXTERNAL_URL' 替换成 external_url
'http://你自己的宿主机 IP:45673'

<!-- `sed -i "s,# external_url 'GENERATED_EXTERNAL_URL',external_url 'http://你自己的宿主机IP:45673',g" /install/gitlab/etc/gitlab.rb` -->
<!-- 上面的容易匹配不了 ，下面的才能更匹配直接换行内容 -->

sed -i "33c external_url 'http://你自己宿主机的 ip:45673'" /install/gitlab/etc/gitlab.rb

#将/gitlab.yml 中的 13 行整行换成 前面 4 个缩进空格（因为是 yml 文件，必须手动输入空格,不然默认整行替换没有缩进，文件内容格式不对）的后面是 host: 你自己的宿主机 IP

`sed -i "13c \ \ \ \ host: 你自己的宿主机IP" /install/gitlab/data/gitlab-rails/etc/gitlab.yml`

#修改 gitlab 容器内部 web 界面服务默认端口 80 为 45673，将/gitlab.yml 中的 14 行整行换成 前面 4 个缩进空格（前面 4 个缩进空格（因为是 yml 文件，必须手动输入空格,不然默认整行替换没有缩进，文件内容格式不对））的后面是 port: 45673

`sed -i "14c \ \ \ \ port: 45673" /install/gitlab/data/gitlab-rails/etc/gitlab.yml `

然后重启 gitlab 服务容器（和第一次启动一样，gitlab 比较大所以需要多等几分钟）

`docker restart gitlab`

`然后用root+初始密码登录==>查看有个默认的Monitoring项目仓库==>看他的clone的地址的IP和端口是否和你浏览器输入的一致（如果是域名就看域名是否一致即可）`

---

##### 验证 gitlab 是否搭建成功

gitlab 容器启动完成以后，至少得等待个 3 分钟左右以上，然后访问 http://你自己的宿主机 IP:45673 ，如果什么都没有，那就再耐心等待几分钟，如果访问出现 502 了，那也就说明服务启动正常的但是还没启动完，还需要再耐心等待 2 分钟左右，再刷新 URL 知道出现下面界面，当然服务器配置很好，也有可能等个 3 分钟就能直接访问到该页面，所以验证 gitlab 是否正常启动的标准就是是否出现登录页面

---

##### root 管理员初始密码查看

gitlab 的默认管理账号是 root，但是初始密码需要根据进入 gitlab 的容器以后输入命令查看进入 gitlab 容器的命令行

`docker exec -it gitlab bash`

查看密码

`grep 'Password:' /etc/gitlab/initial_root_password`

出现一个 password 的后面就是你的 root 的初始登录密码

退出容器,回到宿主机

`exit`

以上 3 个步骤还有个更简单的执行方式，就是下面，把 bsh 换成要执行的命令，就直接在宿主机就可以查看了，不需要进入在退出容器（这种操作同样也可以在其他容器使用，凡是需要进入容器执行命令在退出容器的操作，都可以用这种方式代替）

`sudo docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password`

---

##### 修改 root 账号的初始面的方法

进入 gitlab 以后，先及时修改 root 账号的密码，然后重新登录

`右上角头像=>Edit Profile=>左侧菜单栏 Password=>依次输入旧密码，新密码，确认新密码=>Save Password=>重新登录即可`

[gitlabCI 配置文件点击查看](https://github.com/new-coder-fei/pic/blob/master/images/.gitlab-ci.yml)

---

## 搭建 gitlab-runner 服务

### 执行命令：

#### 拉取 gitlab-runner 的 docker 镜像

`docker pull gitlab/gitlab-runner`

#### 运行 gitlab-runner 的容器服务

`docker run -d --name gitlab-runner --restart always --privileged=true -v /usr/bin/docker:/usr/bin/docker -v /var/run/docker.sock:/var/run/docker.sock -v /install/gitlab-runner/config:/etc/gitlab-runner -v /etc/sysconfig/docker:/etc/sysconfig/docker -v /usr/bin/docker-current:/usr/bin/docker-current gitlab/gitlab-runner:latest`

#### 修改挂载在宿主机的配置文件，依次执行下面三条命令

`sed -i 's!"/cache"!"/cache","/var/run/docker.sock:/var/run/docker.sock","/usr/local/repos/gradle:/usr/local/repos/gradle","/etc/sysconfig/docker:/etc/sysconfig/docker","/usr/bin/docker-current:/usr/bin/docker-current","/usr/bin/docker:/usr/bin/docker"!g' /install/gitlab-runner/config/config.toml`

`sed -i 's,privileged = false,privileged = true,g' /install/gitlab-runner/config/config.toml`

重启 gitlab-runner 容器,让最新配置生效

`docker restart gitlab-runner`

#### 注册 gitlab-runner 执行器到 gitlab

##### 获取 gitlab 仓库 CICD 的 token 以及注册 URL

`新建一个仓库点进去==>左侧菜单Settings==>CICD==>Runners==>复制Register the runner with this URL下面的url==>复制And this registration token`

##### 注册 gitlab-runner 容器到 gitlab

执行命令：

`docker exec -it gitlab-runner gitlab-runner register`

然后按照上面命令给出的提示依次输入，每次输入完成回车到下一项:

`注册URL(上一步获取的)==>注册token（上一步获取的）==>run-desc(命名可以随意)==>run tags(命名可以随意，可以编写ci配置文件会用上) ==>run main(命名可以随意)==>docker(必选docker构建容器)==>alpine:latest(必输docker的版本)`

检验执行器是否注册成功：

`回到之前查看token的那个gitlab页面，刷新一下 在token下面会有一个 Available specific runners ,并且前面的图标是绿色的代表注册成功`

---

## 搭建私有化 registry 镜像仓库服务

### 私有化镜像仓库和 docker 安装的时候自带的镜像库的区别:

`私有化镜像仓库可以给网络相同的任一服务器上面的docker服务提供镜像下载服务，而docker自带的镜像库就是只能给当前服务器上面的docker服务提供镜像依赖`

### 执行命令：

#### 拉取 registry 镜像

`docker pull registry:latest`

#### 运行 registry 容器服务

`docker run -d -v /install/registry:/var/lib/registry -e REGISTRY_STORAGE_DELETE_ENABLED="true" -p 5000:5000 --restart=always --name docker-registry registry:latest`

#### 命令行 curl 验证是否搭建成功

`curl -X GET http://localhost:5000/v2/_catalog`

出现{"repositories":[]}，空数组就说明安装成功了，只是现在还没有上传镜像所以还是空数组
