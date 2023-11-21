```
分层模型结构：
		OSI七层模型：物、数、网、传、会、表、应
		TCP/IP四层模型：网络接口层、网络层、传输层、应用层
		应用层协议：HTTP、FTP、NFS、SSH、TELNET
		传输层协议：TCP、UDP
		网络层协议：IP、ICMP、IGMP
		链路层协议：以太网帧协议、ARP
		
		C/S	client-server			b/s browser-server		

优点：	  缓存大量数据、协议选择灵活		  安全性、跨平台、开发工作量较小
		速度快	

缺点：   安全性、跨平台、开发工作量较大	不能缓存大量数据


数据传输流程：
		数据没封装无法传输。
以太网帧协议：
		ARP协议，根据IP地址获取MAC地址。
		以太网帧协议，根据MAC地址，完成数据包传输。
IP协议：
		IPv4、IPv6
		TTL：time to live	设置数据包在路由节点的跳转上限
		源IP：32位 -----4字节	192.168.1.1	---	点分十进制 IP地址（string）	---二进制
		目的IP：32位 -----4字节
UDP：	//无连接的、不可靠的
		16位：源端口号	2^16 = 65535
		16位：目的端口号
		IP地址：可以在网络环境中，唯一标识一台主机
		端口号：可以在网络的一台主机上，唯一表示一个进程
		IP地址+端口号：可以在网络环境中，唯一表示一个进程。 
TCP:	//面向连接的、可靠的
IP协议：
		16位：源端口号	2^16 = 65535
		16位：目的端口号
		32位序号：
		32位确认序号：
		6个标志位：
		16个窗口大小：		2^16 = 65535
```

```
Socket编程：
		套接字： socket
				一个文件描述符指向一个套接字（该套接字内部由内核借助两个缓冲区实现）
				在通信过程中，套接字一定是成对出现的
		网络字节序：
				小端法：
						高位存高地址，低位存低地址。	int a = 0x12345678
				大端法：
						高位存低地址。低位存高地址 
				htonl --> 本地 --> 网络（IP）
				htons --> 本地 --> 网络（port）
				ntonl --> 网络 --> 本地（IP）
				ntohs --> 网络 --> 本地（port）
		IP地址转换：
				int inet_pton(int af,const char *src,void *dst);	本地字节序(string IP)-->网络字节序
                    成功：1	异常：0  src指向错误地址		失败：-1 
                    af:AF_INET、AF_INET6			//IPv4和IPv6
                    src:IP地址(点分十进制)
                    dst:传出，转换后的网络字节序的IP地址。
                 const char *inet_ntop(int af,const void *src,char *dst,socklen_t size);
                     网络字节序 ---> 本地字节序(string IP)
                     af:AF_INET、AF_INET6			//IPv4和IPv6
                     src:网络字节序IP地址
                     dst:本地字节序(string IP)
                     size: dst的大小。
		sockaddr地址结构：
				struct sockaddr_in addr;
			 	addr.sin_family = AF_INET/AF_INET6
			 	addr.sin_port = htons(9527);		//指定端口号
			 		int dst;
			 		inet_pton(AF_INET,"192.157.22.45",(void*)dst);
			 	addr.sin_addr.s_addr = dst;
			 	//addr.sin_addr.s_addr = INADDR_ANY;//二者都可用。取出系统中有效的任意IP地址，二进制类型
```

![image-20220527163908306](C:\Users\Insummer\AppData\Roaming\Typora\typora-user-images\image-20220527163908306.png)

```
				bind(fd,(struct sockaddr *)&addr,size);
				
				bind();	//绑定IP+port
				listen();	//设置同时监听上线
				accept();	//阻塞监听客户端连接
				
socket函数：
		#include <sys/socket.h>
		int socket(int domain,int type,int protocol);		//创建一个套接字
            domain:AF_INET、AF_INET6、AF_UNIX 					//选用的IP地址协议是哪一个
```

![image-20220527170949826](C:\Users\Insummer\AppData\Roaming\Typora\typora-user-images\image-20220527170949826.png)

```
            type:SOCK_STREAM、SOCK_DGRAM	//创建套接字选用的数据传输协议
            protocol: 0;  
            返回值： 成功：新套接字对应的描述符	失败：-1
            int fd =  socket(int domain,int type,int protocol);	//创建fd接收描述符
		
		
		int bind(int sockfd,const struct sockaddr *addr,socklen_t addrlen);	//给socket绑定一个地址结构
            sockfd：socket函数返回值													（IP+port）
                struct sockaddr_in addr;
                addr.sin_family = AF_INET;
                addr.sin_port = htons(1883);
                addr.sin_addr.s_addr = htonl(INADDR_ANY);		//addr初始化
            addr：传入参数(struct sockaddr*)&addr
            addrlen:sizeof(addr);							//地址结构的大小
            返回值：成功：0	失败：-1
		
		
		int listen(int sockfd,int backlog);		//设置同时与服务器建立连接的上限
			sockfd:socket函数返回值
			backlog：上限数值	最大值128
			返回值：成功：0	失败：-1
		
		
		int accept(int sockfd,struct sockaddr *addr,socklen_len *addrlen);	
		//阻塞等待客户端建立连接，成功返回于客户端连接成功的socket文件描述符
			sockfd：socket的函数返回值
			addr：传出参数。成功与服务器建立连接的那个客户端的地址结构（IP+port）
				socklen_t clit_addr_len = sizeof(addr);
			addrlen：传入传出。	&clit_addr_len
				入：addr的大小	出：客户端addr的实际大小
			返回值：
				成功：能与服务器进行数据通信的socket对应的文件描述。
				失败：-1
				
		int connect(int sockfd,const struct sockaddr *addr,socklen_t addrlen);	
		//使用现有的socket与服务器进行连接
			sockfd：socket的函数返回值
			addr：传入参数。服务器地址结构
			addrlen：服务器地址结构的大小
			返回值：成功：0	失败：-1
			
			如果不适用bind绑定客户端地址结构，采用”隐式绑定“，由系统分配。
			
TCP通信流程分析：
		server：
			socket();	//创建socket
			bind();		//绑定服务器地址结构
			listen();	//设置监听上限
			accept();	//阻塞监听客户端连接
			read();		//读socket获取客户端数据
			toupper();	//小——大写转换
			write();	//
			close();	//
		client:
			socket();	//创建socket 
			connect();	//与服务器建立连接
			write();	//写数据到socket
			read();		//读转换后的数据
			显示读取结果
			close();	// 
			
```

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <pthread.h>
#include <ctype.h>
#include <sys/socket.h>
#include <arpa/inet.h>		//使用地址结构时的头文件

#define SERV_PORT 1883

void sys_err(const char *str)
{
    perror(str);
    exit(1);
}

int main(int argc,char *argv[])
{
    int lfd = 0,cfd = 0;
    int ret;
    char buf[BUFSIZ];		//#define BUFSIZ_IO_BUFSIZ	默认大小4096，也可以不用BUFSIZ。自己设置大小
    struct sockaddr_in serv_addr,clit_addr;  
    
    struct sockaddr_in serv_addr;
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(SERV_PORT);
    serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);	//结构体初始化
    
    lfd = socker(AF_INET,SOCK_STREAM,0)
    if(lfd == -1)
    {
        sys_err("socket error\n");
    }
    bind(lfd,(struct sockaddr*)&serv_addr,sizeof(serv_addr));		//绑定服务器地址结构  
    listen(lfd,128);
    
    clit_addr_len = sizeof(clit_addr);
    cfd = accept(lfd,(struct sockaddr *)&clit_addr,&clit_addr_len);	//阻塞
    if(cfd == -1)
    {
        sys_err("accept error\n");
    }
    while(1)			//循环读取，自己设置条件使循环退出
    {
        ret = read(cfd,buf,sizeof(buf));		//读取数据并赋值到ret
        write(STDOUT_FILENO,buf,ret);
            for(int i = 0;i < ret; i++)
            {
                buf[i] = toupper(buf[i]);			//读取到的数据转换为大写
            }
            write(cfd,buf,ret);
    }
    close(lfd,cfd);
    return 0;
}
```



