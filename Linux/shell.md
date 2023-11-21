```c
#! /bin/bash
echo "hello world!"
```

```
执行脚本 	
	bash *.sh
	/绝对路径/
```

""输出会认为是变量，''输出会原型输出
输出：			    		  echo $变量名
赋值：		       			  变量名=
导出为全局变量：			   export 变量名

常量/静态变量：	 	        readonly 变量名=1
撤销变量：		  			 unset 变量名
带参数执行：		  			"hello $数字"	执行时后面可以带参数
计算参数个数：		  			 $#
所有参数为一体：      			$*	加双引号为一体不独立
参数一体但是每个参数区分对待：		$@ 加双引号依旧独立个体
返回脚本执行结果		 	     $?

![image-20220805135532977](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20220805135532977.png)







<span style="color:red;font-size:30px">运算符</span>
$((运算式)) 或 $[运算式]
运算：    变量名=$((1+5))
加减		expr 1 + 2 或 1 - 2
乘法		expr 1 \* 2 或者
例子：
#! /bin/bash
sum=$[$1+$2]
echo sum=$sum

<span style="color:red;font-size:30px">条件判断</span>
test 条件表达式  或者[ 条件表达式 ] 前后要有空格
条件非空为true	[ atguigu ]放回true	[]放回false

例子：
test $a = hello  或  [ $a = hello ]
echo $?	
为0true，为1false

<span style="color:red;font-size:30px">判断条件</span>
-eq 等于			-ne 不等于
-lt 小于			-le小于等于
-gt 大于			-ge大于等于
字符串比较用	=	判断相等，	!=	判断不等

例子：
[ 1 -lt 2 ]
echo $?

-r	测试读权限
-w	测试写权限
-x	测试执行权限
-e	是否存在
-f	是否存在且是常规文件
-d	是否存在且是否目录
[ -r a.sh ] 







<span style="color:red;font-size:30px">流程控制</span>
<span style="color:red;font-size:30px">单分支</span>
if判断
if	[ 条件判断式 ];then
	程序
fi
或者
if [ 条件判断式 ]
then
	程序
fi

<span style="color:red;font-size:30px">多分支</span>
if [ 条件判断式 ]
elif [ 条件判断式 ]
then
	程序
else
	程序
fi



<span style="color:red;font-size:30px">case语句</span>
case $变量名 in
值1)
	程序
;;
值2)
	程序2
;;
esac

<span style="color:red;font-size:30px">for循环</span>
for (( 初始值;循环控制条件;变量变化 ))
do
	程序
done

for 变量 in 值1 值2 值3
do
	程序
done



<span style="color:red;font-size:30px">while</span>

while [ 条件判断式 ]

do

​		程序	//也可以使用let，例如let sum+=a	let a++

done



<span style="color:red;font-size:30px">read读取控制台输入</span>

read  (选项) (参数)

1.选项

​		-p：指定读取值时的提示符

​		-t ：指定读取时等待的时间(秒)如果-t不加表示一直等待

2.参数

​		变量 ：指定读取值的变量名

![image-20220805141411611](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20220805141411611.png)



<span style="color:red;font-size:30px">函数</span>

<span style="color:blue;font-size:20px">系统函数</span>

basename

![image-20220805142750480](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20220805142750480.png)

dirname

![image-20220805143653297](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20220805143653297.png)





自定义函数

[ function ] funname[()]

{

​	Action;

​	[return int;]

}

调用函数前必须先声明函数

函数返回值只能由$?获得，开通显示加：return 返回值，如果不加，将以最后一条命令运行结果作为返回值，return 后跟数值n[0~255]

![image-20220805150743117](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20220805150743117.png)







归档脚本

![image-20220805155535500](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20220805155535500.png)

![image-20220805155600744](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20220805155600744.png)

定时脚本

![image-20220805155628854](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20220805155628854.png)

0 2 * * * 

分钟  小时 第几天 月 星期几





正则表达式

常规匹配：cat /etc/passwd | grep atguigu

模糊匹配：cat /etc/passwd | grep ^a		//^匹配一行的开头

​					cat /etc/passwd | grep bash$ //$匹配一行的结尾

​					cat /etc/passwd | grep r..t	   //.匹配任意字符,一个点一个字符

​					cat /etc/passwd | grep ro*t	//匹配上个字符0次或多次

​					cat /etc/passwd | grep ^a.*bash$

​					cat /etc/passwd | grep r[a,b]t //匹配ab的，或者12

​					cat /etc/passwd | grep  '\\$'	//转义符，需要单引号括起来

​					

文本处理工具

cut	[选项参数]	filename

选项：

-f	列好，提取第几列

-d	分隔号，按照指定分隔分割列，默认是\t

-c	按字符进行切割，后加n表示取第几列，比如-c 1

![image-20220805162254650](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20220805162254650.png)

![image-20220805162738264](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20220805162738264.png)





awk

awk [选项参数] ‘/pattern1/{action1}’ ‘/pattern2/{action2}’ filename

pattern是需要查找的内容

action是找到内容后执行的命令

-F	指定输入文件分隔符

-v	赋值一个用户定义变量

![image-20220805163538473](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20220805163538473.png)

![image-20220805163945014](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20220805163945014.png)





awk内置变量

FILENAME	文件名

NR				已读的记录数（行号）

NF				浏览记录的域的个数（切割后，列的个数）

cat /etc/passwd |awk -F ":" '{print: "文件名"FILENAME "行号："NR "列数："NF}'



ifconfig | awk '/netmask/ {print $2}'	//显示ip





<span style="color:red;font-size:30px">发送消息案例</span>

检测用户是否登录、是否打开消息功能以及当前发送消息是否为空

![image-20220805171219596](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20220805171219596.png)

![image-20220805171234190](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20220805171234190.png)

![image-20220805171255280](C:\Users\cc\AppData\Roaming\Typora\typora-user-images\image-20220805171255280.png)