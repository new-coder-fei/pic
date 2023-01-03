# nvm的安装与使用

1. 	[nvm安装包,点击下载](https://github.com/new-coder-fei/pic/blob/master/md/nvm/nvm-setup.exe)
2. 	右键安装包以管理员身份运行安装包
   2.1 ![](https://new-coder-fei.github.io/pic/images/nvm/2.png)
   2.2 ![](https://new-coder-fei.github.io/pic/images/nvm/3.png)
   2.3 选择一个非c盘的安装目录
   ![](https://new-coder-fei.github.io/pic/images/nvm/4.png)
   2.4 node安装木可以就用默认的c盘的安装目录
   ![](https://new-coder-fei.github.io/pic/images/nvm/5.png)
   2.5 点击next intsall安装
   ![](https://new-coder-fei.github.io/pic/images/nvm/6.png)
   2.6 找到刚刚新建的nvm安装目录下面的settings.txt文件，将这两行内容复制到文件中并保存文件，不需要重启啥的，直接就生效了
    `node_mirror: https://npm.taobao.org/mirrors/node/`
    `npm_mirror: https://npm.taobao.org/mirrors/npm/`
   ![](https://new-coder-fei.github.io/pic/images/nvm/9.png)
   ![](https://new-coder-fei.github.io/pic/images/nvm/10.png)
   
3. 上一步安装完成以后，用管理员身份运行cmd
	3.1![](https://new-coder-fei.github.io/pic/images/nvm/1.png)
	3.2。执行  `nvm -v` 如下图出现版本号则说明安装成功
	![](https://new-coder-fei.github.io/pic/images/nvm/7.png) 
	3.2. 安装node 14.17.2 目前我自己验证的 这个版本的node兼容vue2 vue3 和react，所以就用这个版本
	继续在cmd执行  `nvm install 14.17.2` ,我已经安装过node14.17.2版本，我下面的截图使用的14.17.1版本做的演示，如下说明成功
	![](https://new-coder-fei.github.io/pic/images/nvm/8.png)
	3.3。执行  `nvm use 14.17.2` 切换使用14.17.2版本
	
4. 重新用管理员身份再打开一个cmd，然后使用node14.17.2版本， 安装vue环境和yarn环境
   4.1执行`npm config set registry https://registry.npm.taobao.org` 修改npm国内淘宝源 
   4.2执行`npm install -g @vue/cli` 安装vue-cli环境
   4.3执行`npm i -g yarn`  安装yarn，后面不管是vue项目还是react项目 yarn安装依赖出错的机率最小
   4.4执行如下3个命令,修改yarn国内镜像源，然后就可以开始vue或者react项目了
   `yarn config set registry https://registry.npm.taobao.org`
   `yarn config set disturl https://npm.taobao.org/dist`
   `yarn config set electron_mirror https://npm.taobao.org/mirrors/electron/`
   
  
	