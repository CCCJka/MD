<font color = "yellow" font size = 30px>linux系统下</font>

SQLite在ubuntu下的安装：

​		本地安装：	sudo dpkg -i *.deb

​		在线安装：	sudo apt-get install sqlite3

​		sqlite不是严格类型匹配的，对于操作的数据类型不会严格检查

命令：			以 . 开头的是系统命令，sql命令不以.开头，但是以分号结尾。

​		.quit	和	.exit	都表示退出

​		sqlite name.db	创建数据库

​		.database	是列出当前打开的数据库

​		.schema	查看表的结构图  

![image-20220606204042678](C:\Users\Insummer\AppData\Roaming\Typora\typora-user-images\image-20220606204042678.png)

![image-20220606204128803](C:\Users\Insummer\AppData\Roaming\Typora\typora-user-images\image-20220606204128803.png)

```C
	增
​		create table name( id Integer , name char , score Integer);			创建表格并加入字段的名称和类型
​		insert into name value(1000,”name“,80);							 			 插入语句,这是完全插入
​		insert into name (id,name)value(1000,"name");								这是部分插入 

​		删
​		delete from name;															删除整个表
​		delete from name where id = 1000;											条件删除		

​		改
​		update name set id = 1000 where score = 50;								将50分的id改为1000。
    
​		查
​		select		查看内容	select * from name; 
​		select * from name where score = 80;				条件查询,多个条件可以用and连接，满足一个可以用or连接

​		

​		alter  table name add column address char;									添加一行地址
​		sqlite不支持删除一整列,但是可以通过这种操作来实现删除一整列
​		create table name1 as select id,name,score from name;				拷贝表格数据，删除了地址这一行
​		drop table name;	删除旧的表格
​		alter table name1 rename to name; 



​		C语言的sqlite编程接口
​		#include <sqlite3.h>										使用需要包含sqlite接口
​		int sqlite3_open(char *path,sqlite3 ** db);		成功返回0，失败返回非0
​		int sqlite3_close(sqlite3 *db);							成功返回0，失败返回错误码
​		const char * sqlite3_errmg(sqlite3 * db);			返回错误信息
```

```C
//编译时需要加入sqlite3		gcc name.c -lsqlite3 
#include <stdio.h>
#include <stdlib.h>
#include <sqlite3.h>

int do_insert(sqlite3 *db)		//插入函数
{
    int id;
    char name[32] = {};
    int score;
    char sql[128] = {};
    char *errmsg;
    printf("input id:");
    scanf("%d",&id);
    getchar();
    printf("input name:");
    scanf("%s",name);
    getchar();
    printf("input score:");
    scanf("%d",&score); 
    getchar();
    sprintf(sql,"insert into name value(%d,'%s',%d);",id,name,score);
    if(sqlite3_exec(db, sql,null,null,&errmsg) != SQLITE_OK)
        printf("%s\n",errmsg);
    else
        printf("insert successful\n") ;
    return 0;
}

int do_delete(sqlite3 *db)		//删除函数
{
    int id;
    char name[32] = {};
    int score;
    
    printf("input id:");	//使用id来进行删除
    scanf("%d",&id);
    getchar();  
    
    sprintf(sql,"delete from name where id = %d",id);
    if(sqlite3_exec(db, sql,null,null,&errmsg) != SQLITE_OK)
        printf("%s\n",errmsg);
    else
        printf("delete successful\n") ;
    return 0; 
}

 int do_update(sqlite3 *db)		//更新函数
{
    int id;
    char name[32] = {};
    int score; 
    char *errmsg;
    printf("input id:");
    scanf("%d",&id);
    getchar(); 
     printf("input score:");
    scanf("%d",&score);
    getchar(); 
     
    sprintf(sql,"update stu set score = %d where id = %d",score,id);
    if(sqlite3_exec(db, sql,null,null,&errmsg) != SQLITE_OK)
        printf("%s\n",errmsg);
    else
        printf("update successful\n") ;
    return 0;
}

int callback(void *para,int f_num,char **f_value,char **f_name)		//回调函数
{
    int i = 0;
    for(i;i<f_num;i++)
    {
        printf("%s\n",f_value[i]);
    }
    putchar(10);
    return 0;
}

int do_query(sqlite3 *db)		//查询函数
{
	char sql[128] = {};
    char *errmsg;
    sprintf(sql,"select * from name;");
    if(sqlite3_exec(db, sql,callback,null,&errmsg) != SQLITE_OK)
        printf("%s\n",errmsg);
    else
        printf("update successful\n") ;
    return 0;
}

//int do_query(sqlite3 *db)		//查询函数,但不使用回调函数，使用get_table
//{
//	char sql[128] = {};
//  char *errmsg;
//  char ** resultp;
//  int nrow,ncloumn;		//定义行数和列数
//  int index;
//  int i,j;
//  sprintf(sql,"select * from name;");
//   if(sqlite3_get_table(db,sql,&resultp,&nrow,&ncloumn,&errmsg) != SQLITE_OK)	//开辟了空间，使用后需要释放
//       printf("%s\n",errmsg);
//  else
//  	printf("Query successful\n");
//  index = ncloumn;
//  for(i = 0;i< nrow;i++)
//  {
//      for(j = 0;j<ncloumn;j++)
//      {
//      	printf("%s\n",resultp[index++]);
//      }
//      putchar(10);
//  }
//  return 0;
//}

int main(int argc,const char *argv[])
{
    sqlite * db;
    char *errmsg; 
    int cmd;
    if(sqlite3_open(database, &db) != SQLITE_OK)
    {
        printf("%s\n",sqlite3_errmsg(db));
        return -1;
    } 
    else
    	printf("open successful\n");
     if(sqlite3_exec(db,"create table name (id Integer,name char,score Integer);",null,null,&errmsg) != SQLITE_OK)
 	     printf("%s\n",errmsg);  
    else
        printf("create successful\n");
    while(1)
    {
        printf("************************************\n");
        printf("1,insert 2,delete 3,query 4,update 5,quit\n");
        printf("************************************\n");
        scanf("%d",&cmd);
        getchar();
        switch(cmd)
        {
            case 1:
                do_insert(db );
                break;
            case 2:
                do_delete(db);
                break;
            case 3:
                do_query(db);
                break;
            case 4：
                do_update(db); 
                break;
            case 5:
                sqlite3_close(db);
                exit(0);
            default:
                printf("Error cmd\n");
        }
    }
    return 0;
}
```



​		

​		