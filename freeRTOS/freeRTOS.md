# 什么是任务？

运行起来的**函数**。任务不仅是代码，他需要保存任务运行到哪一个步骤，需要知道它的运行位置，也需要保存它的运行环境

### 什么叫现场？

暂且认为是任务被打断的时候保存在寄存器内的值。

#### 如何保存现场？

保存在内存里，内存在栈里，现场





# 创建任务

 ```c
xTaskCreate(Task1Function,"Task1",100,NULL,1,&xHandleTask1);		//创建任务
			//	函数指针/任务函数，任务的名字，栈大小、单位，调用任务函数时传入的参数，优先级，任务的句柄，使用它来操作任务
 ```

```c
StackType_t xTask3Stack[100]; 
StaticTask_t xTask3TCB;			

StackType_t xIdleTaskStack[100];
StaticTask_t xIdleTaskTCB;				//创建xTaskCreateStatic需要先创建这些数据然后再创建vApplicationGetIdleTaskMemory函数，才能运行

void vApplicationGetIdleTaskMemory(StaticTask_t ** ppxIdleTaskTCBBuffer,StackType_t ** ppxIdleTaskStackBuffer,uint32_t * pulIdleTaskStackSize)
{
	*ppxIdleTaskTCBBuffer = &xIdleTaskTCB;
	*ppxIdleTaskStackBuffer = xIdleTaskStack;
	*pulIdleTaskStackSize = 100;
}
//需要以上数据和函数才能创建静态任务

xTaskCreateStatic(Task3Function,"Task3",100,NULL,1,xTask3Stack,&xTask3TCB); 		//创建静态任务
```

![image-20220919110237475](C:\Users\Insummer\Desktop\markdown\freeRTOS\创建任务参数.png)

![image-20220919110354458](C:\Users\Insummer\Desktop\markdown\freeRTOS\创建任务参数2.png)





# 删除任务

```c
vTaskDelete();
//这个函数可以杀死任务，NULL作为参数为自杀，参数写入句柄为杀死其他任务
//自杀：vTaskDelete(NULL);
//被杀：别的任务执行vTaskDelete(pvTaskCode);pvTaskCode是自己的句柄
//杀人：执行vTaskDelete(pvTaskCode);pvTaskCode是别的任务的句柄
```



# FreeRTOS任务状态

### Running

### Ready			准备状态，等待启动事件

### Blocked		阻塞状态，等待事件发生					

### suspended  暂停状态，主动休息/被动休息			

### vTaskSuspend();

### vTaskResume();

### vTaskDelay();



# vTaskDelay和vTaskDelayUntil

#### vTaskDelay():至少等待指定个数的Tick Interrupt才能变为Ready

#### vTaskDelayUntil();等待到指定的绝对时刻，才能变为就绪态





# 空闲任务及其钩子函数

- #### 删除任务后的清理工作，是在空闲任务中完成的，比如释放任务的内存

- #### 空闲任务什么时候才能执行？


- #### 空闲任务只能处于这两个状态之一：Running，Ready


- #### 空闲任务钩子函数

  + ##### 执行一些低优先级的、后台的、需要连续执行的函数

  + ##### 测量系统 的空闲时间：空闲任务能被执行就意味着所有的高优先级任务都停止了，所以测量空闲任务占据的时间，就可以算出处理器占用率。

  + ##### 让系统进入省电模式：空闲任务能被执行就意味着没有重要的事情要做，当然可以进入省电模式。

  + ##### 绝对不能导致任务进入Blocked、Suspended状态

  + ##### 如果会使用vTaskDelete()来删除任务，那么钩子函数要非常高效地执行。如果空闲任务移植卡在钩子函数里的话，他就无法释放内存。



# 任务调度算法

创建任务时如果将任务优先级设置为0（也就是空闲任务）后再创建任务调度器后会创建一个空闲任务。freeRTOS创建任务应该是最后创建的任务先运行，如果启用任务调度器并且所有任务的优先级为0，那么最后一个任务创建后任务调度器会创建一个空闲任务

例如：任务1->任务2->任务3->空闲任务		会先运行空闲任务然后1->2->3,而不是3->1->2，所以任务优先级很重要

  

### 在freeRTOS中，最低等级的中断也比最高等级的任务优先级高，中断永远先执行

任务是人设定的，中断是系统强制进行的







# 通过链表理解调度机智

+ 可抢占：高优先级任务先执行
+ 时间片轮转：同优先级的任务轮流执行
+ 空闲任务礼让：如果有同是优先级0的其他就绪任务，空闲任务主动放弃一次运行机会





# 深入理解freeRTOS的队列





# 多任务系统中互斥的引入

 例如两个任务同时访问变量a，但是任务1访问到一半时被任务2抢占了，那么此时任务1中保存的值为0，当任务2运行完时a++已经成功，此时a=1，然后再运行任务1恢复现场时a的值还是0，再a++，这就是导致运行一次时a++的值是错误的 



+ ### 队列怎么实现互斥访问

使用**关中断**和**开中断**来实现互斥访问

关中断后别的任务就无法打断某个任务来打断任务的运行



+ ### 使用队列的第二个好处





+ ### 队列的核心

关中断、环形缓冲区、链表

通过关中断实现互斥

通过环形缓冲区来保存数据

通过链表实现休眠和唤醒

```
唤醒操作
xTaskWaitingToSend(); 
把queue.xTaskWaitingToSend中第一个任务移除
把他从DelayList移到ReadyList链表
```



+ ### 队列的超时唤醒







+ ### 引入信号量

信号量是一种特殊的队列，队列用来传递数据，但信号量不能传递数据，他是用来修改计数值的

 信号量用来表示资源的个数

 



+ ### 信号量操作流程

获取信号量：Take

```
a、关中断
b、if(count > 0)
{

}
c、else
{
return ERR(不等待)	/	休眠  放入Semaphore list -> Readylist移到DelayList
}
d、count++ 
	return OK;
```



释放信号量:Give

```
a、关中断
b、count++
c、SemaphoreList非空？有没有任务在等待 非空或任务在等待则唤醒Semaphorelist
```





+ ### 互斥量的引入（优先级反转与继承）

  + #### 优先级反转  

  

  

  

  + #### 优先级继承

当高优先级的任务获取不到互斥量时，会提升拥有互斥量的任务的优先级，然后等待拥有互斥量的任务运行完再获取互斥量并将之前提升的任务的优先级降低为原先的优先级。



+ ### 事件组

 
