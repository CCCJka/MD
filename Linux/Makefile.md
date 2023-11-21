# 【1】Makefile

#     （1）Make简介

​	 ==1）工程管理器，顾名思义，是指管理较多的文件==
​	 2）Make工程管理器也就是个“自动编译管理器”，这里的“自动”是指它==能够根据文件时间戳==

​	==自动发现更新过的文件而减少编译的工作量，同时，它通过读入Makefile文件的内容来执行大量的编译工作== 
​	 3）Make将只编译改动的代码文件，而不用完全编译。

##     （2）Makefile基本结构 

​	 ==Makefile是Make读入的唯一配置文件==
​	 1）由make工具创建的目标体（target），通常是目标文件或可执行文件
​	 2）要创建的目标体所依赖的文件（dependency_file）
​	 3）创建每个目标体时需要运行的命令（command）
​	 4）注意:命令行前面必须是一个”TAB键”,否则编译错误为:*** missing separator.  Stop.

#### 	 Makefile格式

​		target  :   dependency_files
​		<TAB>  command
​		例子
​		hello.o :  hello.c hello.h
​		    gcc  –c  hello.c  –o  hello.o

##     （3）Makefile变量 

​	 一个复杂一些的例子
​	sunq:kang.o yul.o
​	    gcc kang.o yul.o -o sunq
​	kang.o : kang.c kang.h 
​	    gcc –Wall –O -g –c kang.c -o kang.o
​	yul.o : yul.c 
​	    gcc - Wall –O -g –c yul.c -o yul.o
​	注释:
​		==-Wall:表示允许发出gcc所有有用的报警信息.==
​     		==-c:只是编译不链接,生成目标文件”.o”==
​     		==-o file:表示把输出文件输出到file里==
​	关于更多的用man工具

##     （4）创建和使用变量

### 	1）创建变量的目的:

​	   用来代替一个文本字符串:
​    	    1.系列文件的名字  

​			2.传递给编译器的参数 

​			3.需要运行的程序 

​			4.需要查找源代码的目录 

​			5.你需要输出信息的目录  

​			6.你想做的其它事情。 	

### 2）变量定义的两种方式

a. 递归展开方式VAR=var
b. 简单方式 VAR：=var

变量使用$(VAR)
	用”$”则用”$$”来表示、
	类似于编程语言中的宏 

### 3)刚才的例子

  OBJS = kang.o yul.o
  CC = gcc
  CFLAGS = -Wall -O -g
  sunq : $(OBJS)
      $(CC) $(OBJS) -o sunq
  kang.o : kang.c kang.h
      $(CC) $(CFLAGS) -c kang.c -o kang.o
  yul.o : yul.c yul.h
      $(CC) $(CFLAGS) -c yul.c -o yul.o

### 4)递归展开方式VAR=var

  例子:
  	foo = $(bar) 
	bar = $(ugh) 
	ugh = Huh? 
	$(foo)的值为?
	echo $(foo)来进行查看

### 5)优点：

​	 它可以向后引用变量
  缺点： 不能对该变量进行任何扩展，例如 
 	 CFLAGS = $(CFLAGS) -O 
​	 会造成死循环

### 6)简单方式 VAR：=var

​	m := mm 
​	x := $(m) 
​	y := $(x) bar 
​	x := later 
​	echo $(x) $(y) 
​	看看打印什么信息?
 用这种方式定义的变量，会在变量的定义点，按照被引用的变量的当前值进行展开 
 这种定义变量的方式更适合在大的编程项目中使用，因为它更像我们一般的编程语言 

### 7）用?=定义变量 

​	dir := /foo/bar
​	FOO ?= bar
​	FOO是?
​    含义是，如果FOO没有被定义过，那么变量FOO的值就是“bar”，
​    如果FOO先前被定义过，那么这条语将什么也不做，其等价于：
​	ifeq ($(origin FOO), undefined)
  		FOO = bar
​	endif

### 8）为变量添加值 

   你可以通过==**+=**==为已定义的变量添加新的值 
   **Main=hello.o hello-1.o**
   **Main+=hello-2.o**

### 9）预定义变量

​	**AR**     库文件维护程序的名称，默认值为ar。AS汇编程序的名称，默认值为as。
​	**CC**     C编译器的名称，默认值为cc。CPP  C预编译器的名称，默认值为$(CC) –E。
​	**CXX**    C++编译器的名称，默认值为g++。
​	**FC**     FORTRAN编译器的名称，默认值为f77
​	**RM**     文件删除程序的名称，默认值为rm -f

### 10）例子:

​	Hello: main.c main.h 
​	<tab> $(CC) –o hello main.c
​	clean:
​	<tab> $(RM) hello

11) 预定义变量
	
	**ARFLAGS** 	 库文件维护程序的选项，无默认值。
	**ASFLAGS**	 汇编程序的选项，无默认值。
	**CFLAGS**  	 C编译器的选项，无默认值。
	**CPPFLAGS**	 C预编译的选项，无默认值。
	**CXXFLAGS	** C++编译器的选项，无默认值。
	**FFLAGS**		 FORTRAN编译器的选项，无默认值。
12) 刚才的例子
	
	OBJS = kang.o yul.o
	CC = gcc	
	CFLAGS = -Wall -O -g
	sunq : $(OBJS)
	    $(CC) $(OBJS) -o sunq
	kang.o : kang.c kang.h
	    $(CC) $(CFLAGS) -c kang.c -o kang.o
	yul.o : yul.c yul.h
	    $(CC) $(CFLAGS) -c yul.c -o yul.o
	
	### 13)自动变量
	
	==**$***==	  不包含扩展名的目标文件名称
	
	==**$+**==	  所有的依赖文件，以空格分开，并以出现的先后为序，可能 包含重复的依赖文件
	==**$<**==	   第一个依赖文件的名称
	==**$?**==	   所有时间戳比目标文件晚的的依赖文件，并以空格分开
	==**$@**==          目标文件的完整名称
	==**$^**==	   所有不重复的目标依赖文件，以空格分开
	==**$%**==         如果目标是归档成员，则该变量表示目标的归档成员名称
14) 刚才的例子：
	OBJS = kang.o yul.o
	CC = gcc
	CFLAGS = -Wall -O -g
	sunq : $(OBJS)
	    $(CC) $^ -o $@
	kang.o : kang.c kang.h 
	    $(CC) $(CFLAGS) -c $< -o $@
	yul.o : yul.c yul.h
	    $(CC) $(CFLAGS) -c $< -o $@
15) 环境变量
	1) make在启动时会自动读取系统当前已经定义了的环境变量，并且会创建与之具有相同名称和数值的变量
	   1) 如果用户在Makefile中定义了相同名称的变量，那么用户自定义变量将会覆盖同名的环境变量 
	       (5) Make使用
           直接运行make 
	       选项
	       ==**-C**==	dir读入指定目录下的Makefile
	       ==**-f**== 	file读入当前目录下的file文件作为Makefile
	       ==**-i**==	 忽略所有的命令执行错误
	       ==**-I**== 	dir指定被包含的Makefile所在目录
	       ==**-n**==	只打印要执行的命令，但不执行这些命令
	       ==**-p**==	显示make变量数据库和隐含规则	
	       ==**-s**==	在执行命令时不显示命令
	       ==**-w**==	如果make在执行过程中改变目录，打印当前目录名





### 【1】Make使用

​	直接运行make 
​	选项
​		==**-C**==	dir读入指定目录下的Makefile
​	     ==**-f**== 	file读入当前目录下的file文件作为Makefile
​	     ==**-i**==	 忽略所有的命令执行错误
​	     ==**-I**== 	dir指定被包含的Makefile所在目录
​	     ==**-n**==	只打印要执行的命令，但不执行这些命令
​	     ==**-p**==	显示make变量数据库和隐含规则	
​	     ==**-s**==	在执行命令时不显示命令
​	     ==**-w**==	如果make在执行过程中改变目录，打印当前目录名

### 【2】Makefile的隐含规则

​	隐含规则1：编译C程序的隐含规则
​	“<n>.o”的目标依赖目标会自动推导为“<n>.c”并且其生成命令是“$(CC) -c $(CPPFLAGS) $(CFLAGS)”
​	隐含规则2：链接Object恩建的隐含规则
​	“<n>”目标依赖于“<n>。o”,通过运行C的编译器来运行链接程序生成（一般是“ld”），
​	其生成命令是：“$(CC) $(LDFLAGS) <n>.o”
​	“$(LOADLIBES) $(LDLIBS)”，这个规则对于只有一个源文件的工程有效，同时也对多个Object文件（由不同的源文件生成）的也有效
​	例如如下：
​		规则：
​		x:x.o y.o z.o
​		并且“x.c”、“y.c”和“z.c”都存在时，隐含规则将执行如下命令：
​		cc -c x.c -o x.o
​		cc -c y.c -o y.o
​		cc -c z.c -o z.o
​		cc x.o y.o z.o -o x
​		如果没有一个源文件（如上例中的x.c）和你的目标名字（如上例中的x）相关联，
​		那么，你最好写出自己的生成规则，不然，隐含规则会报错的

### 【3】VPATH的用法

​    （1）VPATH：虚路径
​	 1）   在一些大的工程中，有大量的源文件，我们通常的做法是把这许多的源文件分类，
​	 并存放在不同的目录中。所以，当make需要去寻找文件的依赖关系，你可以在文件
​	 前加上路径，但最好的方法是把一个路径告诉make，让make在自动去找。
​	 2）   Makefile文件中的特殊变量“VPTH”就是文成这个功能的，如果没有指明这个变量，
​	 make只会在当前的目录中去找寻依赖文件和目标文件。如果定义了这个变量，那么make就会在当前
​	 目录找不到的情况下，到所指定的目录中去找寻文件了。

	 3) VPATH = src:../headers
	 4) 上面的定义指定两个目录，“src”和“../headers”，make会按照这个顺序进行搜索。
	    目录由“冒号”分隔。当然，当目前目录永远是最高的优先搜索的地方

### 【4】嵌套的Makefaile

​    （1）案例

	 - 我们注意到有一句@echo $(SUBDIRS)
	 - @（RM）并不是我们自己定义的变量，那它是从哪里来的呢？
	 - make -C $@
	 - export CC OBJS BIN OBJS_DIR BIN_DIR

![image-20220826103550367](C:\Users\cc\Desktop\markdown\makefile.png)