SQLite的命令有3种类型：

+ DDL：数据定义语言
+ DML：数据操作语言
+ DQL：数据查询语言

数据定义语言：

+ CREATE：此命令用于创建表、表或数据库中其他对象的试图
+ ALTER:它用于像表一样修改现有数据库对象
+ DROP：DROP命令用于删除整个表、表或数据库中其他对象的视图

数据操作语言：

+ INSERT：此命令用于创建命令
+ UPDATE：用于修改记录
+ DELETE：用于删除记录

SQLite数据类型：

+ NULL：指定该值为空值
+ INTEGER：指定值是一个有符号整数，根据值的大小存储在1、2、3、4、6或8个字节中
+ REAL：指定值是一个浮点值，存储为一个8字节的IEEE浮点数
+ text：指定值为文本字符串，使用数据库编码（utf-8、utf-16be或utf-16le）存储
+ BLOB：指定值是一个数据块，完全按照输入的方式存储

SQLite关联类型：

+ SQLite支持列的类型关联。任何列任然可以存储任何类型的数据，但是列的首选存储类称为其关联
+ SQLite中由以下类型关联用于分配
  + Affinity   描述
    + TEXT：此列用于使用存储类NULL、TEXT或BLOB存储所有数据
    + NUMERIC：此列可能包含使用所有五个存储类别的值
    + INTEGER：行为与具有数字关联的列相同，但是强制转换表达式中例外
    + REAL：行为类似具有数字关联的列，只有它强制数值转换为浮点表示
    + NONE：具有关联性NONE的列不偏爱一种存储类而不是另一种存储类，并且不会将数据从一个存储类说服到另一个
+ 日期和时间数据类型
  + 在SQLite中，没有单独的类来存储日期和时间，但是您可以将日期和时间存储为TEXT、REAL或INTEGER值
    + TEXT：以类似“yyyy-mm-dd  hh-mm-ss.sss”的格式指定日期
    + REAL：指定自公元前4714年11月24日中午在格灵威治的天数
    + INTEGER：指定自1970-01-01 00:00:00 UTC以来的秒数
+ SQLite运算符：
  + 使用where子句执行比较和运算等操作时，以SQLite运算符作为多个条件连接
    + 算术运算符
      + \+  加法运算符：用于两边相加
      + \-   减法运算符：用于左边减去有变
      + \*   乘法运算符：用于将两边的值相乘
      + /   除法运算符：将左边除以右边
      + % 模运算符：左边除以右边并返回余数
    + 比较运算符
      + ==  判断两数是否相等
      + = 
    + 逻辑运算符
    + 按位运算符

![image-20220606201926220](C:\Users\Insummer\AppData\Roaming\Typora\typora-user-images\image-20220606201926220.png)

![image-20220606202026915](C:\Users\Insummer\AppData\Roaming\Typora\typora-user-images\image-20220606202026915.png)

![image-20220606202044015](C:\Users\Insummer\AppData\Roaming\Typora\typora-user-images\image-20220606202044015.png)

![image-20220606202102743](C:\Users\Insummer\AppData\Roaming\Typora\typora-user-images\image-20220606202102743.png)

![image-20220606202135257](C:\Users\Insummer\AppData\Roaming\Typora\typora-user-images\image-20220606202135257.png)



![image-20220606202458019](C:\Users\Insummer\AppData\Roaming\Typora\typora-user-images\image-20220606202458019.png)