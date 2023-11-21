右键桌面或者空白处，点击Git bash here

使用命令进行全局配置：
git config --global user.name "username"		//最好和Github用户名一致

git config --global user.email "email-address"	//同上

git init			//进入目录后进行git初始化

git常用指令：

git status		//查看当前状态

git add			//添加文件到git缓存区		git add . 添加当前目录到缓存区中

git commit -m "注释内容"	//提交至版本库

版本回退：

​				查看版本

​				git log								//显示详细

​				git log -pretty = oneline 	//只显示一行

​				回退操作：

​				git reset --hard 提交编号

git reflong	//查看历史操作，可回到当前版本



远程仓库：

基于http协议，使用指令 clone 线上仓库地址

git clone 线上仓库地址

git push	//提交到线上仓库的命令

初次使用git push提交可能遇到403错误，需要修改隐藏文件夹.git/config的内容

```
 url"https://username:Password@github.com/username/filename.git"
```

拉取线上仓库数据

git pull

工作后每天第一件事就是git pull，下班前最后一件事就是git push



分支相关指令：

git branch		//查看分支

git branch 分支名	//创建分支

git checkout 分支名	//切换分支

git branch -d 分支名	//删除分支

git merge 被合并的分支名	//合并分支 

分支之间的操作互不影响，可用合并来获取其他分支的操作



忽略文件:

 使用忽略文件需要先使用touch命令来创建一个.gitignore，声明忽略的或不忽略的文件的规则，生效范围时当前目录以及子目录

/mtk/		//过滤整个文件夹

*.zip		//过滤所有zip文件，zip可替换为别的文件格式

/mtk/do.c	//过滤某个具体的文件

!index.php	//使用!表示不过滤的文件