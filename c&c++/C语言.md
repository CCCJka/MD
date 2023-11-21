设有数组定义：char array[ ]="China";，则数组array所占的空间为（<font color='Yellow'>6个字节</font>）

![image-20220318162455851](..\picture\image-20220318162455851.png)

<hr style = "background-color:#78d2e9;">

```c
int f(int n) {
    int i = 0;//经过第一个for运算，i的初始值为12
    for (int k = 1; k <= n; k *= 2)
        ++i;
    for (int j = i / 2; j > 0; --j) {
        int v1 = (1 << (j - 1));
        int v2 = (1 << (i - j));
        bool flag1 = ((n & v1) != 0);
        bool flag2 = ((n & v2) != 0);
        if (flag1 != flag2) {
            n ^= v1;
            n ^= v2;
        }
    }
    return n;
}
 
int main(int argc, char* argv[]) {
    printf("%d", f(3456));
    return 0;
}
```

![image-20220318171704489](..\picture\image-20220318171704489.png)

<hr style = "background-color:#78d2e9;">

![image-20220318172620065](..\picture\image-20220318172620065.png)

![image-20220318172634069](..\picture\image-20220318172634069.png)

<hr style = "background-color:#78d2e9;">

![image-20220318201028599](..\picture\image-20220318201028599.png)
<font color = "Yellow">纯虚函数除了有virtual 关键字外，还令它等于0，以表为纯虚函数。拥有纯虚函数的类称为 抽象类<br>B纯虚函数，C虚函数</font>

<font color="red" size = 5>虚函数是C++的内容</font>

<font color="yellow">虚函数可以直接使用，纯虚函数只有被实现了才能被使用<br>因为纯虚函数只有声明，没有被定义的<br>![image-20220404152828541](..\picture\image-20220404152828541.png)<br>不能被重载的运算符 1、. (成员访问运算符) 2、.* (成员指针访问运算符) 3、:: (域运算符) 4、sizeof(长度运算符) 5、?: (条件运算符)</font>

<hr style = "background-color:#78d2e9;">

![image-20220318201420352](..\picture\image-20220318201420352.png)

![image-20220318201428708](..\picture\image-20220318201428708.png)

<font color = "yellow">使用伪指令#pragma pack (n)，C编译器将按照n个字节对齐。<br>使用伪指令#pragma pack ()，取消自定义字节对齐方式<br>8=4+1+补齐1+2；12=1+补齐3+4+2+补齐2。<br><br><br>\#pragma pack(2) 为预指令 (2)中数字为代表默认对齐数改为2 一般在vs编译器下默认对齐数设为8 预指令进行更改<br>如何找每一个成员体的对齐数呢 ？把相应成员体大小与默认对齐数相比 较小值为相应对齐数<br>第一个 4+1+1(浪费的空间)+2=8 大小为占空间最大成员4的倍数则成立<br>下面的#pragma pack()意思是取消上面设置的默认对齐数2<br>第二个同理 1+3(浪费的空间)+4+2=10 由于10不是最大成员体所占空间4的倍数 因此要补到12 故答案为12</font>

<hr style = "background-color:#78d2e9;">

<font color="yellow">宏定义不做语法检查。预处理是在编译之前的处理，而编译的工作之一便是语法检查，所以预处理不做语法检查。<br>题中的S(a,b)是没问题的，有问题的调用的地方。宏定义在代码中只是简单的替换，调用时简单的将S(a,b)替换为“t=a;a=b;b=t“，编译时会显示t未定义。<br>但是若是只是有宏定义，但代码中未使用S(a,b)的话，是不会出现t未定义的情况的，因为在代码中压根就没有替换来的”t=a;a=b;b=t“.</font>

<hr style = "background-color:#78d2e9;">

![image-20220318203325411](..\picture\image-20220318203325411.png)

<font color = "yellow">对于D选项，简要说明一下：<br>D选项，去掉&后其实就是我们见到的最基本的返回值问题，其返回值为局部变量。<br>**其实问题就变成了为什么不能返回局部变量地址，却可以返回局部变量？**<br>局部变量用作返回值时，会生成一个**局部变量的拷贝用作返回值**，之后局部变量会被系统回收；<br>函数不能返回局部变量的地址，因为如果返回局部变量的地址，系统回收后，指针、引用指向的内容就无意义了。</font>

<hr style = "background-color:#78d2e9;">

<font size = 10>C语言中的<font color="yellow"> const：</font></font>


全局变量使用const时<font color = "yellow">不能直接修改和使用取地址修改</font>

Example:

![image-20220319210102889](..\picture\image-20220319210102889.png)

局部变量使用const时也不可以直接修改，<font color = "yellow">但是可以通过指针取地址修改值</font>

Example:
![image-20220319210252240](..\picture\image-20220319210252240.png)

<font size = 10 color = "yellow">const修饰指针：</font>

Example:

![image-20220319210534190](..\picture\image-20220319210534190.png)

<hr style = "background-color:#78d2e9;">

<font size = 20 color = "yellow">结构体、共用体和枚举</font>

![image-20220319212637596](..\picture\image-20220319212637596.png)

![image-20220319213010187](..\picture\image-20220319213010187.png)

![image-20220319213040475](..\picture\image-20220319213040475.png)


<hr style = "background-color:#78d2e9;">
<font size  = 10 color = "yellow">链表</font>

<font size  = 5 color = "skyblue">单向链表：</font>

![image-20220320195337421](..\picture\image-20220320195337421.png)

![image-20220320195300840](..\picture\image-20220320195300840.png)

<font size = 5 color = "skyblue">链表的构成：</font>

```c
typedef struct student{
    int num;
    char name[20];
    struct student *next;
}STU;
```

<font color = "yellow">链表节点分为两个域：</font>

<font color = "yellow">数据域：</font>存放各种实际的数据，如：num；

<font color = "yellow">指针域：</font>存放下一个节点的数据，如：next

<font color = "yellow" size = 5>   列表的操作:</font><font color = "skyblue" size = 5>增、删、改、查</font>






<hr style = "background-color:#78d2e9;">
<font size = 5 color = "yellow">文件的刷新缓冲区</font>

标准io库函数往标准输出（屏幕）输出东西的时候是<font color  ="yellow">行缓冲</font>的

行缓冲就是缓冲区碰到<font color = "yellow">换行符</font>才刷新缓冲区

![image-20220325154230654](..\picture\image-20220325154230654.png)

![image-20220325154353249](..\picture\image-20220325154353249.png)

![image-20220325154829103](..\picture\image-20220325154829103.png)




<hr style = "background-color:#78d2e9;">
<font size = 5 color = "yellow">C语言文件IO</font>

<font size = 5 color = "skyblue">fopen</font>

![image-20220326160111250](..\picture\image-20220326160111250.png)

![image-20220326160323701](..\picture\image-20220326160323701.png)

![image-20220326160500478](..\picture\image-20220326160500478.png)

```c
#include <stdio.h>

int main()
{
    FILE *fp;
    //使用fopen函数打开或者创建文件，返回文件指针
    
    fp = fopen("D:/VSCode/fileio","r");     
    //以只读的方式打开文件，如果文件不存在则报错
    
    //fp = fopen("D:/VSCode/fileio","w");     
    //以只写的方式打开文件，如果文件不存在则创建，如果文件存在则清空文件
    
    //fp = fopen("D:/VSCode/fileio","a");     
    //以只写的方式打开文件，如果文件不存在则创建，如果文件存在则追加
    if (fp == NULL)
    {
        printf("fail to fopen\n");
        return -1;
    }
    return 0;
}
```



<font size = 5 color = "skyblue">fclose</font>![image-20220326161828616](..\picture\image-20220326161828616.png)



<font size = 5 color ="skyblue">fgets/fputs</font>![image-20220326195045320](..\picture\image-20220326195045320.png)

<font size = 5 color ="skyblue">fgets</font>

![image-20220326195201022](..\picture\image-20220326195201022.png)

<font size = 5 color ="skyblue">fputs</font>

![image-20220326195240012](..\picture\image-20220326195240012.png)

<font size = 5 color ="skyblue">fread</font>

![image-20220326201417065](..\picture\image-20220326201417065.png)

![image-20220326201527658](..\picture\image-20220326201527658.png)

<font size = 5 color ="skyblue">fwrite</font>

![image-20220326202540311](..\picture\image-20220326202540311.png)

<font size = 5 color = "yellow">格式化读写文件函数</font>

![image-20220326203612519](..\picture\image-20220326203612519.png)

<font size = 5 color ="skyblue">rewind文件定位函数</font>

![image-20220326204136210](..\picture\image-20220326204136210.png)



<font size = 5 color ="skyblue">ftell文件定位函数</font>![image-20220326204247166](..\picture\image-20220326204247166.png)

<font size = 5 color ="skyblue">fseek文件定位函数</font>

![image-20220326204442601](..\picture\image-20220326204442601.png)


<hr style = "background-color:#78d2e9;">
![image-20220404153507624](..\picture\image-20220404153507624.png)
<font size = 5 color = "yellow"> 想想按位或的特点是什么，原来是1的地方运算之后还是1，所以1只会多不会少，但是因为是使用了右移的结果进行运算，所以1最多也就填满传入的那个参数的所有bit，如果是左移不就最多可以把整个类型所占的bit全部置为1吗？所以只需要把665所占的bit数找出来，我们知道2^10=1024占11个bit即1 00000 00000，因为665小于1024大于512所以占10个bit，10个bit全1，当然是1023了。能用巧劲别下苦力啊亲们！重复事情应该交给机器来干，能靠巧妙的思维或辅以少量运算来做，实在想不到好办法才去硬算的题才是好题。如果是非要大量硬算的题，只能说明出题人水平才是真的不行，没搞清楚招聘的是程序员而不是计算机。</font>

```
665二进制编码 0010 1001 1001
右移一位后为  0001 0100 1100(符号位为0右移不需要补符号位0)
按位与       0011 1101 1101
右移两位后    0000 1111 0111
按位与        0011 1111 1111
接下来的操作无济于事
结果就是0011 1111 1111 即 1023 
```



![image-20220404160511041](..\picture\image-20220404160511041.png)

<font size = 5 color = "skyblue">本题考查函数调用时的数据流向问题。简单变量只能实现单向的值传递。在调用函数时，通常在主调函数和被调函数之间有数据传递关系。在定义函数时，函数名后面括号中的变量名称为“形参”；在调用函数时，函数名后面括号中的变量名称为“实参”。有关实参和形参的说明如下：<br> (1)形参在函数未被调用时，不占用存储单元，只有在发生函数调用时形参才被分配内存空间，函数调用结束后，释放形参所占的内存空间。 <br>(2)在被定义的函数中，必须指定形参的类型。<br> (3)实参可以是常量、变量或表达式。<br> (4)实参与形参的类型应一致。<br> (5)如果形参是简单变量，实参对形参的数据传递是按值传递，即单向传递，只能由实参传给形参，不能由形参传回来给实参。 如果形参是地址变量，实参对形参的数据传递是按地址传递，可以实现双向传递，既能由实参传给形参，又能由形参传回来给实参</font>



<font size = 5 color = "yellow">个人认为：这里的简单变量应该是指内置类型，内置类型数据在传入函数时，使用值传递方式的效率要高于引用传递和指针传递，因此编译器会采用效率最高的方式来实现参数传递，所以选B（当然也允许用户更改），事实上包括STL中的迭代器和函数对象也都是默认采用值传递的方式来实现的。
至于其他类型如自定义类，如果采用值传递则会涉及拷贝构造函数和析构函数的调用问题，通常会影响性能，所以一般采用引用和指针传递的形式，通常交由用户决定。
一点题外话：有人说设计自定义类型的最高境界是让他无限接近内置类型，不无道理。</font>





<font size = 5 color = "yellow">不可重载运算符包括 	?:	::	.	.*    这四个</font>



![image-20220404164328557](..\picture\image-20220404164328557.png)

<font size = 5 color = "yellow">D。<br>x86是小端存储，即高位存储在高地址，低位存储在低地址。<br>int a = 0xabcd1234;<br>内存中 ab  cd  12  34，b作为一个char，右边表达式指针指向为0x34.<br>高  -->    低</font>

<font size = 5 color = "yellow">重点在于X86是小端机器<br>char只能读取int的一个字节,在加上16进制
<br>在小端机上是低位 0x34
<br>大端机上读取的是高位0xab</font>





![image-20220404164727147](..\picture\image-20220404164727147.png)

<font size = 5 color = "yellow">C语言中实数常数的科学表示法规定格式为：“实数e整数”或“实数E整数”，其中幂是整数，不能写成实数。e(或E)前后的实数和整数都不能省略掉，因此选项C和D都是错误的。选项B的-080，由于C语言规定。0开头的是八进制数，0x(0x)开头的是十六进制数。而八进制数数字是0～7，出现8是错误的，因此选项B也是错误的。只有选项A是正确的。实数的小数点前后的数字都可以不写。</font>





![image-20220404164812847](..\picture\image-20220404164812847.png)

```
答案为 D 。

y=f(f(x)) 有两层 f() ，为了说明过程，把里面的一层标明为 f_1 ，外面一层标明为 f_2 。则 7 次调用分别是：
                              x  ->  f_1 的 u
f_1 的 u  ->  f_1 的 v

f_1 的 v  ->  f_1 的 w

f_1 的 w  ->  f_2 的 u

f_2 的 u  ->  f_2 的 v

f_2 的 v  ->  f_2 的 w

f_2 的 w  ->  y
```



![image-20220404170445954](..\picture\image-20220404170445954.png)

![image-20220404170433687](..\picture\image-20220404170433687.png)


<hr style = "background-color:#78d2e9;">



<hr style = "background-color:#78d2e9;">


