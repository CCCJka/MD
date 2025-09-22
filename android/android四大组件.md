# **1、activity**

Activity可以看成是安卓系统的根本，在这个根本上才可以进行其他的工作，因为在安卓系统里运行的所有的程序，它的流程都必须在【Activity】中运行，所有他是最基本的模块。它的作用是一个框架或页面，每个程序会有多个【Activity】组成。

Activity组件，在应用中的一个Activity可以用来表示一个界面，意思可以理解为“活动”，即一个活动开始，代表 Activity组件启动，活动结束，代表一个Activity的生命周期结束。一个Android应用必须通过Activity来运行和启 动，Activity的生命周期交给系统统一管理。

（1）一个Activity通常就是一个单独的屏幕（窗口）。

（2）Activity之间通过Intent进行通信。

（3）android应用中每一个Activity都必须要在AndroidManifest.xml配置文件中声明，否则系统将不识别也不执行该Activity。

## 三个基本状态：

Resumed 一个新Activity启动入栈后，它在屏幕最前端，处于栈的最顶端，此时它处于可见并可和用户交互的激活状态。

Paused 当Activity被另一个透明或者Dialog样式的Activity覆盖时的状态。此时它依旧与窗口管理器保持连接，系统继续维护其内部状态，所以它依然可见，但它己经失去了焦点故不可与用户交互。

Stopped 当Activity被另一个Activity覆盖、失去焦点并不可见时处于Stopped状态

## 七大方法

**onCreate()** Activity创建时第一个调用的方法,通常我们在该方法中加载布局文件，初始化UI组件，事件注册等等

**onStart()** 在onCreate方法之后调用，用于显示界面，但当前用户不能进行交互

**onResume() **在onStart方法后调用，该方法执行完成后，用户可进行交互，当前Activity进入Resumed状态（运行状态）；当一个Paused状态的activity被重新返回时，会再次调用该方法，让Activity进入运行状态

**onRestat() **当一个Stopped状态的Activity被返回时，该方法被调用，之后再调用onResume()方法进入运行状态

**onPause()** 当 其他Activity(透明或窗口模式)进入时，该方法会被调用，让当前Activity进入Paused状态(暂停状态)；当前Activity还可见 但不可交互，如果其他更高优先级的app需要内存时，当前Activity可能会被销毁(kill)；当前Activity被返回时会调用 onResume()方法

**onStop()** 当其他Activity完全覆盖该Activity时，该方法被调用，当前 Activity进入Stopped状态(停止状态)；当前Activity不可见,如果其他更高优先级的app需要内存时，当前Activity可能会 被销毁(kill)；当前Activity被返回时会调用onRestart()方法

**onDestroy() **当前Activity被销毁时调用，通常在该方法中用来释放资源，当前Activity killed

```java
//正常来说，Activity的生命周期只有以下七个
/*1.onCreate：
    每个Activity在写代码的过程中都会看见这个函数，
    是声明周期的第一个方法。
    一般做一些资源和数据初始化的工作，
    比如绑定相对应的资源布局setContentView*/
        @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
    
    
/*2.onStart:
    这个状态我理解就是Activity启动中的一个过程，
    就是启动中，但是还不能与用户交互（用户不可见）,
    属于一个在后台的状态*/
        @Override
    protected void onStart() {
        super.onStart();
    }
    
    
/*3.onResume:
    表示Activity已经可见，且已经开始活动。
    与onStart类似的状态但是就是属于一种在前台的状态*/
        @Override
    protected void onResume() {
        super.onResume();
    }


/*4.onRestart:
    字面意思表示Activity重新启动，这个状态一般由用户切换应用的行为产生，
    比如从应用切换到桌面或者切打开新的Activity，
    此时这个Activity就会调用onPause和onStop让这个Activity进入展厅状态。
    再回到这个Activity就是onRestart了*/
        @Override
    protected void onRestart() {
        super.onRestart();
    }
    
    
/*5.onPause:
    是一个非常微妙的状态，处于正在停止的一个临界点，
    就很难重现这种状态，就是在停止过程中，
    先执行onPause然后在onStop执行之前，
    回到Activity执行onResume，这期间就是onPause的状态。
    此处可以做一些存储数据停止动画的工作，但是不能太耗时，
    不然会影响到新Activity的显示，只有这些操作做完，
    新Activity的OnResume才会执行。*/
        @Override
    protected void onPause() {
        super.onPause();
    }
    
    
/*6.onStop:
    表示Activity即将停止，可以做一些相对重量级的回收工作，
    同样不能太耗时。*/
    @Override
    protected void onStop() {
        super.onStop();
    }

/*7.onDestroy
    表示Activity即将被销毁，这是Activity生命的尽头，
    可以做一些回收工作和资源的释放。*/
    @Override
    protected void onDestroy() {
        super.onDestroy();
    }

```

### Android系统中的进程优先级从高到底分别为，前台进程，可见进程，服务进程，后台进程，空进程。

前台进程：用户正在交互的进程。

可见进程：部分界面能被用户看见，却不再前台与用户交互，不影响界面事件的进程。

服务进程：包含已启动服务的进程。

空进程	：空白缓存区

# Fragment：

Fragment依附于Activity，只有在Activity才能运行，可以称为子Activity。

Fragment可以在Activity的xml中使用，例如：

```java
<Fragment 
name    fragmentname
match_parent
match_parent
@id/fragemntid />
```

Fragment可以添加进类似栈的功能，页面先进后出

```java
FragmentManager fm = getSupportFragmentManager();
FragmentTransaction ft = fm.beginTransaction();
ft.replace(R.id.fragmentid,fragment);
ft.addToBackStack(null);			//添加进类似栈的功能
ft.commit();
```

Activity发送信息给Fragment:

原生方案：Bundle

```java
Bundle bundle = new Bundle();
bundle.putString(key,value);
Fragment fm = new Fragment();
fm.setArguments(bundle);
ft.replace(R.id.fragmentid,fm);
```

生命周期：

由于Fragment依附于Activity，所以他的生命周期一定在onAttach于onDetach之间
**onAttacht**->t**onCreate**->**onCreateView**->**onActivityCreated**->**onStart**
->**onResume**->**onPause**->**onStop**->**onDestroyView**->**onDestroy**->**onDetach**

打开界面：

onCreate->onCreateView->onActivityCreate->onStart->onResume

按下主界面：

onPause->onStop

重新打开界面：

onStart->onResume

后退键：

onPause->onStop->onDestroyView->onDestroy->onDetach

# **2、service**

Service是安卓里非常很重要的组件，它的地位和优先级别是与活动相似的，不过Service不能够自己运行，它只能在安卓的后台运行。它的作用就是与安卓的其他组件进行交互，举个简单例子：当我们打开手机上音乐播放器并将它放到后台，此时播放的音乐就是由Service在负责控制。

1）service用于在后台完成用户指定的操作。service分为两种：

- started（启动）：当应用程序组件（如activity）调用startService()方法启动服务时，服务处于started状态。
- bound（绑定）：当应用程序组件调用bindService()方法绑定到服务时，服务处于bound状态。

2）startService()与bindService()区别：

- started service（启动服务）是由其他组件调用startService()方法启动的，这导致服务的onStartCommand()方法被调用。当服务是started状态时，其生命周期与启动它的组件无关，并且可以在后台无限期运行，即使启动服务的组件已经被销毁。因此，服务需要在完成任务后调用stopSelf()方法停止，或者由其他组件调用stopService()方法停止。

  - startService的生命周期如下

  - ```java
    startService() → onCreate() → onStartCommand() → [服务运行] → stopService()/stopSelf() → onDestroy()
    ```

- 使用bindService()方法启用服务，调用者与服务绑定在了一起，调用者一旦退出，服务也就终止，大有“不求同时生，必须同时死”的特点。

  - bindService的生命周期如下

  - ```java
    bindService() → onCreate() → onBind() → [服务绑定运行] → unbindService() → onUnbind() → onDestroy()
    ```


3）开发人员需要在应用程序配置文件中声明全部的service，使用<service></service>标签。

4）Service通常位于后台运行，它一般不需要与用户交互，因此Service组件没有图形用户界面。Service组件需要继承Service基类。Service组件通常用于为其他组件提供后台服务或监控其他组件的运行状态。 

5）可在Application中bindService成功后再解绑就行绑定预热，这样可加快服务启动的速度

6）可以先执行startService后再进行bindService，比较推荐该操作。这样可以同时享有两种方式的好处，但需要更注意生命周期的问题

# **3、content provider（内容提供商）**

内容提供商这个组件是专门为第三方应用而设计的，它非常的灵活，而且相当重要，它会为所有的应用准备一个内容窗口，并且保留数据库、文件，作用就是我们在使用这些第三方软件的时候，可以有效的访问，并且保护里面的数据。

1）android平台提供了Content Provider使一个应用程序的指定数据集提供给其他应用程序。其他应用可以通过ContentResolver类从该内容提供者中获取或存入数据。

2）只有需要在多个应用程序间共享数据是才需要内容提供者。例如，通讯录数据被多个应用程序使用，且必须存储在一个内容提供者中。它的好处是统一数据访问方式。

3）ContentProvider实现数据共享。ContentProvider用于保存和获取数据，并使其对所有应用程序可见。这是不同应用程序间共享数据的唯一方式，因为android没有提供所有应用共同访问的公共存储区。

4）开发人员不会直接使用ContentProvider类的对象，大多数是通过ContentResolver对象实现对ContentProvider的操作。

5）ContentProvider使用URI来唯一标识其数据集，这里的URI以content://作为前缀，表示该数据由ContentProvider来管理。

内容提供的场景应用于QQ、微信获取通讯录信息，广告推送、媒体库之类的

需要在AndroidMainFest中注册provider才可以就行内容共享

# **4、broadcast receiver（广播接收器）**

在安卓系统中，广播接收器并不是直接就可以看到的，它是程序之间传递信息时的一种机制，作用就是接收或者发送通知。通俗的来说广播接收器更像是一种传递组件，它能够将信息接收，甚至还可以对它进行过滤然后进行响应。

1）你的应用可以使用它对外部事件进行过滤，只对感兴趣的外部事件(如当电话呼入时，或者数据网络可用时)进行接收并做出响应。广播接收器没有用户界面。然而，它们可以启动一个activity或serice来响应它们收到的信息，或者用NotificationManager来通知用户。通知可以用很多种方式来吸引用户的注意力，例如闪动背灯、震动、播放声音等。一般来说是在状态栏上放一个持久的图标，用户可以打开它并获取消息。

2）广播接收者的注册有两种方法，分别是**程序动态注册**和**AndroidManifest**文件中进行**静态注册**。

3）动态注册广播接收器特点是当用来注册的Activity关掉后，广播也就**失效**了。静态注册无需担忧广播接收器是否被关闭，只要设备是开启状态，广播接收器也是打开着的。也就是说哪怕app本身未启动，该app订阅的广播在触发时也会对它起作用。

广播接收器的类型

Normal broadcasts：默认广播

Ordered broadcasts：有序广播

Sticky broadcasts：粘性广播

广播的例子有很多，例如王者荣耀中的电量、WIFI强弱都是广播接收的，安卓可以当接收同时也可以当发送，当软件需要一些数据时就可以接收或者发送广播来获取数据，将接收到的数据显示在需要显示的地方。

```java
//创建监听
IntentFilter intentfilter = new IntentFilter();
//监听的频道
intentfilter.addAction(Intent.ACTION_BATTERY_CHANGED);
//创建对象
BatteryReceiver batteryReceiver = new BatteryReceiver();
//注册广播
this.registerReceiver(batteryReceiver,intentFilter);
//同时需要在AndroidMainFest注册user-permission的Battery-STATUS


//一个广播需要继承		extern BroadcastReceiver
public class BatteryReceiver extern BroadcastReceiver{
    @override
    public void OnReceive(Contexe context,Intent intent){
        String action = intent.getAction();
        Log.d(TAG,"接收到的是");
        //logcat输出接收到的是android.Intent.ACTION_BATTERY_CHANGED
        Log.d(TAG,"当前电量:"+intent.getIntExtra(BatteryManager.EXTRA_LEVEL,0));
        //接收到电量变化显示电量
        
    }
}
```



# 总结

**Activity**：

是整个应用程序的门面，主要负责应用程序当中数据的展示，是各种各样控件的容器，是用户和应用程序之间交互的接口

**Service**：

在前台不可见，但是承担大部分数据处理工作，和Activity的地位是并列的，区别在于Activity运行于前台，Service运行于后台，没有图形用户界面，通常他为其他的组件提供后台服务或监控其他组件的运行状态

**BroadcastReceiver**：

实现消息的异步接收，他非常类似事件编程中的监听器，但他与普通事件监听器有所不同，普通的事件监听器监听的事件源是程序中的控件，而BroadcastReceiver监听的事件源是Android应用中其他的组件

**ContentProvide**r：

为不同的应用程序之间数据访问提供统一的访问接口，通常它与ContentResolver结合使用，一个是应用程序使用ContentProvider来暴露自己的数据，而另外一个是应用程序通过ContentResolver来访问数据
