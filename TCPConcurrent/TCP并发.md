# select函数使用

![image-20220913171714300](..\TCPConcurrent\select.png)

![image-20220913172627092](..\TCPConcurrent\select调用过程.png)

![image-20220913173051509](..\TCPConcurrent\select函数的宏定义.png)

```c
#include <stdio.h>
#include <stdlin.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc,char *argv[])
{
	/*变量定义*/
	fd_set rfds;	//定义文件描述符集合
	struct timeval tv; //定义时间结构体
	int retval;		//用于接收返回值
	char buf[BUFSIZ] = {};	//接收读取到的字符，BUFSIZ是系统内置的宏，一般为8142
	
	//调用宏定义FD_ZERO清理文件描述符集合rfds
	FD_ZERO(&rfds);
	
	/*调用宏定义FD_SET将文件描述符0加入到文件描述符集合rfds
	*0：标准输入
	*1:标准输出
	*2:标准错误
	*/
	FD_SET(0,&rfds);
	
	/*设置时间结构体，最多等待5秒钟*/
	tv.tv_sec = 5;
	tv.tv_usec = 0;	//微秒，1秒等于1000000微秒
    
    //调用select函数监听文件描述符集合，本例只有一个0
    retval = select(1,&rfds,NULL,NULL,&tv);
    
    //返回值为-1表示函数调用失败
    if(retval == -1)
    {
        perror("select");		//打印错误
    }
    else if (retval)		//返回值非0，隐含条件是大于0，表示有可读的文件描述符
    {
        printf("数据现在可用\n");
        //FD_ISSET(0,&rfds)为真;
        if(FD_ISSET(0,&rfds))
        {
            read(0,buf,sizeof(buf));
            printf("buf = %s\n",buf);
        }
    }
    else		//隐含条件，retval大于0，表示超时返回，没有文件是可读状态
    {
        printf("返回，没有数据可读\n");
    }
    
    //调用exit函数结束程序
    exit(EXIT_SUCCESS);
    
	return 0;
}
```

![image-20220914094637389](..\TCPConcurrent\优缺点.png)