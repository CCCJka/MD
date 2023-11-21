

面向对象：将整个项目拆分为不同的对象，例如：人负责编程，电脑负责编译和出结果
面向过程：将整个项目拆分成一系列的步骤，例如：提出需求->完成需求->编译->结果



面向过程更直接高效，面向对象更易于维护、拓展以及复用

# 面向对象

封装：意义在于提供外部可调用的接口。无需对封装的函数知根知底，可以只学会如何调用，做一个API调用工程师



继承：继承基类的方法，并可以做出自己的改变或者拓展。子类共性的方法或者属性可以直接使用父类的，无需自己再定义，只需要选择是否拓展自己的个性化



多态：基于对象所属类的不同，外部对同一个方法的调用，实际执行的逻辑不同。

多态的三个条件：继承、方法重写、父类应用指向子类对象

```
父类类型 变量名 = new 子类对象;
变量名.方法名();
```

多态易于维护，这是多态的优点。但是多态有个弊端，他无法调用子类特有的功能，如果子类的方法不是重写父类的，是子类独有的，那么这个方法是使用不了的

# JDK、JRE、JVM三者区别和联系

JDK：Java Development kit 	java开发工具					



JRE：Java Runtime Environment	java运行时环境		运行java程序的环境



JVM：Java Virtual Machine	java虚拟机 						javac编译class文件让程序能运行



JDK包含JRE和java工具，JRE含有bin(ivm)和bin，java工具有javac，java，jconsole

<span style='color:文字颜色;background:背景颜色;font-size:文字大小;font-family:字体;'>文字</span>



# ==和equals

==对比的是<span style='color:red;font-size:30px'>栈</span>中的值,基本数据类型是变量值，引用类型是堆中内存对象的地址

Ex：	int i = 1		基本数据类型是在栈中分配，如果使用==比较则返回true

Ex：	如果使用引用类型String对比则为false，原因为String a实际上是new String a，地址不一样，所以两个String使用==对比为false





equals：object中默认也是采用==比较，通常会重写。equal可以用于字符串的内容

```java
String str1 = "hello";
String str2 = new String("hello");
String str3 = str2;
system.out.println(str1 == str2);		//false
system.out.println(str1 == str3);		//flase
system.out.println(str2 == str3);		//true
system.out.println(str1.equals(str2));		//true
system.out.println(str1.equals(str3));		//true
system.out.println(str2.equals(str3));		//true
```





# 为什么Java里有基本数据类型和引用数据类型？

引用类型在堆里，基本类型在栈里。

栈空间小且连续，往往会被放在缓存。引用类型cache miss率高且要多一次解引用。

对象还要再多储存一个对象头，对基本数据类型来说空间浪费率太高

除了8种基本数据类型<span style='color:red;font-size:30px'>以外</span>都是引用数据类型，8中基本数据类型分别是<span style='color:red;font-size:30px'>byte,short,int,long,char,boolean,float,double</span>



# final作用

修饰类：表示类不可继承

修饰方法：表示方法不可被子类覆盖，但是可以重载

修饰变量：表示变量一旦被赋值就不可更改它的值

1、（修饰成员变量）

+ 如果final修饰的是类变量，只能在静态初始化块中指定初始值或者声明该类变量是指定初始值。
+ 如果final修饰的是成员变量，可以在非静态初始化块声明该变量或者构造器中执行初始值。

2、修饰局部变量

+ 系统不会为局部变量进行初始化，局部变量必须由程序员显示初始化，因此使用final修饰局部变量时，即可以在定义时指定默认值，如果在定义时指定默认值，那么后续就不可以更改了。也可以不指定默认值，选择在后面的代码中对final变量赋值，也是赋值后就不能更改了

3、修饰基本类型数据和引用类型数据

+ 如果是基本数据类型的变量，那么在一开始赋值后就不能进行更改。
+ 如果是引用类型的变量，则在对其初始化之后便不能再让其指向另一个对象，<span style='color:red;font-size:20px'>但是引用的值是可变的</span>

```java
public class FinalReferenceTest{
    public static void main(){
        final int[] iArr = {1,2,3,4};
        iArr[2] = -3;	//允许
        iArr = null;	//不允许，对iArr不能重新赋值
        
        final Person p = new Person(25);
        p.setAge(24);	//允许
        p.setAge(null);		//不允许
    }
}
```



#### 为什么局部内部类和匿名内部类只能访问局部final变量？

编译之后会生成两个class文件，Test.class	Test1.class

![image-20221122155448578](C:\Users\Insummer\Desktop\markdown\JAVA\final.png)

![image-20221122155619809](C:\Users\Insummer\Desktop\markdown\JAVA\final2.png)

内部类和外部类属于同一个级别，内部类不会因为定义在方法中就随着方法的执行完毕就被销毁

但有个问题，但外部类的方法结束时，局部变量就会被销毁，但是内部类对象可能还存在（只是没有人再引用时，所以死亡）。但是出现了一个矛盾，内部类访问了一个不存在的变量。为了解决这个问题，将局部变量复制了一份作为内部类的成员变量，这样当局部变量死亡后，内部类依然可以访问它，实际访问的是局部变量的“copy"，这样就像是延长了局部变量的生命周期



# String、StringBuffer、StringBuilder区别和使用场景

#### String是final修饰的，不可变，每次操作都会产生兴的String对象

#### StringBuffer和StringBuilder都是再原对象上操作

#### StringBuffer是线程安全的，StringBuilder是线程不安全的

StringBuffer方法都是synchronized修饰的

性能：StringBuilder>StringBuffer>String



使用场景：继承需要改变字符串内容时使用后面两个

优先使用StringBuilder，多线程使用共享变量时使用StringBuffer









