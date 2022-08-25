<!--
 * @Author: error: git config user.name && git config user.email & please set dead value or install git
 * @Date: 2022-08-24 10:09:30
 * @LastEditors: error: git config user.name && git config user.email & please set dead value or install git
 * @LastEditTime: 2022-08-25 17:41:48
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

# docker+jenkins+maven+springboot+vue 前后端自动化环境搭建第二章

### 部署springboot项目

#### 安装Maven Integration插件，可以帮我们快捷的开始springboot的maven项目

![](https://new-coder-fei.github.io/pic/images/jenkins/33.png)

![](https://new-coder-fei.github.io/pic/images/jenkins/34.png)

#### 安装Publish Over SSH插件，可以帮助我们将打包的好的jar或者其他文件传送到真正部署的主机，并且执行我们一些脚本来启动运行服务，因为一般部署服务的主机和打包的主机是不同，同样单台主机打包部署也支持发送相关文件，然后给配置over SSH插件

![](https://new-coder-fei.github.io/pic/images/jenkins/53.png)

##### 配置 over SSH步骤1：首页==》系统管理==》系统配置，Passphrase：如果私钥设置了密码就是私钥的密码，私钥没设置密码可以不填

Path to key：私钥的位置

Key：私钥的内容。如果此处填入了值，则以此处的值为准，咱们使用的是容器的形式，所以私钥的内容不用私钥的路径

![](https://new-coder-fei.github.io/pic/images/jenkins/54.png)
![](https://new-coder-fei.github.io/pic/images/jenkins/55.png)

##### 配置 over SSH步骤2：在jenkins容器所在的宿主机（并非jenkins容器内部==>亲测容器内部生成的无效）生成ssh密钥和公钥，公钥发送到各个jenkins需要链接的服务器，这样就可以可以实现免ssh账号密码登录服务器，在宿主机执行 ` ssh-keygen`生成公私钥，默认生成在` /root/.ssh` 目录下面，` id_rsa`是私钥文件，` id_rsa.pub`  是公钥文件,然后执行` ssh-copy-id -i /root/.ssh/id_rsa.pub -p 服务器ssh端口，有的默认不是22端口 root@服务器IP`将公钥文件发送到服务器，然后确认yes，输入服务器的密码即可， 链接多个服务器就需要执行多次该命令将文件发送到多个服务器 【经过验证该公钥和私钥还是要在jenkins容器的宿主机上面进行，然后使用私钥的内容字符串，不用私钥路径进行】
<!--参考链接： https://www.cnblogs.com/iXiAo9/p/16282260.html -->
![](https://new-coder-fei.github.io/pic/images/jenkins/56.png)
![](https://new-coder-fei.github.io/pic/images/jenkins/57.png)

##### 配置 over SSH步骤3：在jenkins的web管理界面新增一个刚才发送过公钥的服务器

![](https://new-coder-fei.github.io/pic/images/jenkins/58.png)


#### 安装gitlab插件或者gitee插件，取决于你的代码是用的哪个仓库，如果都在用，这两个插件都可以下载

![](https://new-coder-fei.github.io/pic/images/jenkins/35.png)

![](https://new-coder-fei.github.io/pic/images/jenkins/36.png)

![](https://new-coder-fei.github.io/pic/images/jenkins/37.png)

#### 首页==》新建任务==》输入项目名称（一般可以和git仓库中的项目名称一致）==》选择构建一个maven项目==》点击确定


![](https://new-coder-fei.github.io/pic/images/jenkins/45.png)

##### 选择General，这一项只需要输入项目描述就行
![](https://new-coder-fei.github.io/pic/images/jenkins/46.png)


##### 选择源码管理，选择git（不论仓库是github还是gitlab还是gitee都是git类型仓库），填写仓库的clone地址

![](https://new-coder-fei.github.io/pic/images/jenkins/40.png)

![](https://new-coder-fei.github.io/pic/images/jenkins/41.png)

![](https://new-coder-fei.github.io/pic/images/jenkins/42.png)

![](https://new-coder-fei.github.io/pic/images/jenkins/43.png)

![](https://new-coder-fei.github.io/pic/images/jenkins/44.png)

![](https://new-coder-fei.github.io/pic/images/jenkins/47.png)


##### 选择构建触发器（根据git仓库的类型选择对应的），下面以gitee为例，勾选Gitee webhook 触发构建，再找到Gitee webhook密码，点击右边的生成按钮，会生成一串密钥，记录下来，一会在gitee仓库去填写该密钥和勾选Gitee webhook 触发构建后面的url， 其他的选项都不同动 就使用默认的，

![](https://new-coder-fei.github.io/pic/images/jenkins/48.png)

![](https://new-coder-fei.github.io/pic/images/jenkins/49.png)

![](https://new-coder-fei.github.io/pic/images/jenkins/50.png)

![](https://new-coder-fei.github.io/pic/images/jenkins/51.png)


##### maven的项目构建环境，Pre Steps不用选择，跳过


##### Build，输入打包需要执行的maven命令，一般就是clean和 package

![](https://new-coder-fei.github.io/pic/images/jenkins/52.png)


##### 构建设置也不用选择

##### 构建后操作（也就是打包以后做什么，通常咱们就是需要将包部署到服务器上面运行了）

![](https://new-coder-fei.github.io/pic/images/jenkins/60.png)




### 部署vue前端项目
#### 打包部署前端vue或者react项目基本也一样的配置，除了新建任务的时候，任务类型不选择maven类型，选择构建一个自由类型的项目，以及构建环境选择 Provide Node & npm bin/ folder to PATH ，以及下面执行的over ssh 拷贝文件和执行的命令不一样以外基本都一样

![](https://new-coder-fei.github.io/pic/images/jenkins/62.png)
![](https://new-coder-fei.github.io/pic/images/jenkins/61.png)
![](https://new-coder-fei.github.io/pic/images/jenkins/63.png)


##### 远端服务器后端文件上传目录 示例,[查看获取部署后端dockerfile文件示例](https://new-coder-fei.github.io/pic/images/jenkins/java/Dockerfile),[查看获取部署后端启动脚本示例](https://new-coder-fei.github.io/pic/images/jenkins/java/restart_java.sh)

![](https://new-coder-fei.github.io/pic/images/jenkins/64.png)

##### 远端服务器前端文件上传目录 示例，[查看获取部署前端dockerfile文件示例](https://new-coder-fei.github.io/pic/images/jenkins/vue/Dockerfile),[查看获取部署前端启动脚本示例](https://new-coder-fei.github.io/pic/images/jenkins/java/restart_vue.sh),[查看获取部署前端nginx.conf示例](https://new-coder-fei.github.io/pic/images/jenkins/java/nginx.conf)

![](https://new-coder-fei.github.io/pic/images/jenkins/65.png)