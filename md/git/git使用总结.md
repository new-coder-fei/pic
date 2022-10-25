# git使用技巧

## git commit 的时候feat,fix等关键字的使用


## git commit 的频率

git commit 的提交频率一定要控制到最小的某个具体的功能点上面或者某个需求上面，越频繁越好，切记不能写了很多功能点以后在提交一个commit，这样不利于后期代码回滚等操作

待补充

## 一次git回退合并的操作场景记录

当时我正在开发新功能，同事也在开发新功能,但是我是在同时开发了几个功能（他这几个功能暂时不能上线）以后再在他分支基础上面开发的
，然后当我的完成时候 ，他开发的所有功能都不能上线，但是我的必须先上线 【我和他的功能没有共同文件，也没有业务关系】所以总结了
以下回退方案==》对git命令进一步加深


1. 从包含我们所有共同功能的dev分支上面，使用`git checkout -b hotfix-dev origin/dev`拉取生成一个新的线上热补分支取名称为hotfix-dev（名称可以随意命令）
    然后使用`git push origin hotfix-dev`
    
2. 使用`git reset --hard commit_id `命令将hotfix-dev本地分支强制回退到同事未修改前的线上版本的那一次commit_id（这个操作
   会在hotfix-dev本地分支删除这此commitId以后所有的commit提交,并且经本人测试，reset --hard只会影响当前分支，不会删除其他的分支的commit），然后使用`git push -f origin hotfix-dev `推送更新远程分支
   
3. 然后在当前分支hotfix-dev使用`git cherry-pick $commit_id` 我的两个commitid(可以在远端的dev分支的commit查看，hotfix-dev上的已经被删除找不到了),分两次从最近的依次合并到当前分支，然后`git push -f origin hotfix-dev`推送更新远程分支       
    
    
 
    
