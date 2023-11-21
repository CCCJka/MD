```c++
#include <iostream>
#include <thread>
using namespace std;

void ThreadMain(){
	cout << "Start Thread" << endl;
}

int main(int argc, char* argv[]){
	thread th(ThreadMain);		//创建线程并启动
	th.join();				//阻塞等待子线程退出

	return 0;
}
```

join()函数的**作用是让主线程的等待该子线程完成，然后主线程再继续执行**。

这种情况下，子线程可以安全的访问主线程中的资源。子线程结束后由主线程负责回收子线程资源。

*一个子线程只能调用join()和detach()中的一个，且只允许调用一次*。

可以调用joinable()来判断是否可以成功调用join()或detach()。

# 注意

　　**1、****为了确保子线程程序在发送异常退出前完成，就需要对注意调用join()函数的位置**，否则当主线发生异常而此时还没有调用到join()函数，那么子线程随主线程终止。**解决方法是在异常处理中调用join()。**

　 **异常发生的情况，**子线程没有完成就随主线程终止。

**2、为了应对忘记使用join()和选择位置的问题，可以使用RAII机制来管理子线程，在RAII析构中调用join()。**这样在我根本不需要考虑join的位置问题，还是是否忘记的问题。但是这个方式在程序异常的情况下并不能保证主线程被终止时，子线程执行结束。因为程序因异常而终止时，如果没有捕获，对象的析构不会发生，只能由系统来回收资源。关于RAII：https://www.cnblogs.com/chen-cs/p/13027205.html

　　**使用RAII在析构中调用join()**