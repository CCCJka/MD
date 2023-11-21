## Intent:

<img src="..\picture\image-20230506232249713.png" alt="image-20230506232249713" style="zoom:50%;" />

显式Intent：代码直接写明跳转的Intent，例如：Intent intent = new Intent(this,second.class);

隐式Intent：无明确跳转的Intent，只有模糊的动作字符，属于模糊匹配。

```java
Intent intent = new Intent();
intent.setAction(Intent.ACTION_DIAL);//跳转到拨号
Uri uri = Uri.parse("tel:"+"123");	//设置默认拨号123
intent.setData(uri);	//发送数据
startActivity(intent);
```

通过Intent发送数据到下一个Activity
```java
//发送数据
Intent intent = new Intent(this,second.clas);
Bundle bundle = new Bundle();
bundle.putString("string","123");
intent.putExtras(bundle);
//获取数据
Bundle bundle = getIntent.getExtras();
String str = bundle.getString("string");
```

将数据发送到上一个Activity

```java
//使用startActivityforResult方法	頁面A
Intent intent = new Intent(this,second.clas);
Bundle bundle = new Bundle();
bundle.putString("string","123");
intent.putExtras(bundle);
startActivityforResult(intent);
//獲得上一個頁面返回的數據		頁面B
Intent intent = new Intent(this,second.clas);
Bundle bundle = new Bundle();
bundle.putString("string","456");
intent.putExtras(bundle);
setResult(Activity.RESULT_OK,intent);	//發送返回的數據代碼
finish();

//startActivityforResult的替代方案	頁面A
ActivityResultLauncher<IntentSenderRequest> register = registerForActivityResult(new 			ActivityResultContracts.StartIntentSenderForResult(), new ActivityResultCallback<ActivityResult>() {
            @Override
            public void onActivityResult(ActivityResult result) {
                if(result != null){
                    Intent intent = result.getIntent();
                    if(intent != null && result.getResultCode() == Activity.RESULT_OK){
                        Bundle bundle = getIntent.getExtras();
                        String str = bundle.getString("string");
                    }
                }
           }
        });
```



# 进程与线程

+ 进程：是一个具有独立功能的程序关于某个数据集合的一次运行活动。进程是系统进行资源分配和调度的一个独立单位。可以申请和拥有系统资源，是一个动态的概念，是一个活动的实体，是一个“执行中的程序”。不只是程序的代码，还包括当前的活动。
+ 线程：线程是进程的一个实体，是CPU调度和分派的基本单位，它是比进程更小的能独立运行的基本单位。线程比进程更小，基本上不拥有系统资源，故对它的调度所用资源小，能更高效的提高系统内多个程序间并发执行的程度。



进程和线程都是操作系统里的程序的基本单元。

进程相当于任务管理器里的程序exe，而线程因为划分尺度小于进程，所以多线程的并发性高。

进程在执行的时候拥有独立的内存单元，而多个线程共享内存，执行效率会更加高

线程必须依附在应用程序中，由程序执行调度



线程是指进程内的一个**执行单元**,也是进程内的可调度实体，与进程的区别：

+ 地址空间: 进程内的一个执行单元;进程至少有一个线程，它们共享进程的地址空间;而进程有自己独立的地址空间;
+ 资源拥有: 进程是资源分配和拥有的单位,同一个进程内的线程共享进程的资源
+ 线程是处理器调度的基本单位,但进程不是
+ 二者均可并发执行

# 线程池

池化思想：线程池、字符串常量、数据库连接池

提高资源利用率

+ 手动创建线程对象
+ 执行任务
+ 执行完毕，释放线程对象

线程池的优点：

+ 提高线程的利用率
+ 提高程序的响应速度
+ 便于统一管理线程对象
+ 可以控制最大并发数

当阻塞的任务多于队列的时候，队列会产生一种应对策略，临时创建一个新的应急线程。

创建一个应急线程来容纳将队列外的任务。

当线程池的线程以及达到最大值的时候且队列已经满了的时候，队列会采用拒绝策略，将新的任务拒绝。

```java
ExecutorService executorService = new ThreadPoolExecutor(核心线程数,
													最大线程数,
													存活时间,
													时间单位,
													等待队列的长度(new ArrayBLockingQueue<>(3),
													线程工厂(Executors.defaultThreadFactory()),
													默认拒绝策略(new ThreadPoolExecutor.AbortPolicy()));
									
//使用
for(i = 0;i<9;i++){
    //使用朗木达表达式 ()->{}
	executorService.execute(()->{
        System.out.println(Thread.currentThread.getName());	//显示线程池的池数和当前使用的线程 pool-1-thread-1/-2/-3
    })
}
```



## 解决线程安全问题：

不共享数据，可以在变量前加final后使用get方法创建一个新的对象。

共享数据可以使用乐观锁（CAS）、悲观锁（）、普通加锁（synchronized）。

死锁有**简单型顺序死锁**、**动态型顺序死锁**

死锁产生的原理：

简单型顺序死锁：

+ 操作线程 >= 资源		Ex：两个线程操作两个变量

+ 加锁的顺序不对        EX:线程抢占的变量顺序不相同，相同不会产生死锁

动态型顺序死锁：

+ 使用hashcode判断加锁顺序

+ 尝试拿锁 

+ ```java
  Lock lock = new ReentrantLock();
  if(lock.tryLock()){
      try{
          //代码
      }finally{//释放锁一定要放在finally里面
          lock.unlock();
      }
  }
  ```

活锁：线程A拿了a锁，线程B拿了b锁，当A想拿b时会释放a锁，B也同样，然后一直循环

# OOM

OOM，也就是out of memory，内存问题，不是**内存泄漏**就是**内存溢出**

造成OOM的原因由以下几点：

+ **大量位图的加载**
  + 有时候我们需要从网络上获取大量的图片并且展现在 view 中，但是如果图片较大，一次性加载大量 Bitmap，那么程序可用内存会瞬间增长，引起 OOM。
+ **位图对象没有及时释放**
  + 当程序中需要操作 Bitmap 对象的时候，当它不在被使用的时候，可以调用 Bitmap.recycle()方法回收此对象的像素所占用的内存，如果对 Bitmap 没有及时释放，在程序长期运行过程中，就很有可能造成 OOM 意外情况的发生。
+ **查询数据库没有关闭游标**
  + 程序中经常会进行查询数据库的操作，但是经常会有使用完毕 Cursor 后没有关闭的情况。如果我们的查询结果集比较小，对内存的消耗不容易被发现，只有在常时间大量操作的情况下才会复现内存问题，这样就会给以后的测试和问题排查带来困难和风险。
+ **构造 Adapter 时，没有使用缓存的 convertView**
  + 如果我们不去使用 convertView，而是每次都在 getView()中重新实例化一个 View 对象的话，即浪费资源也浪费时间，也会使得内存占用越来越大。

## ANR就是应用程序未响应的弹窗



## Socket

**基于TCP的Socket**

```java
@RequiresApi(api = Build.VERSION_CODES.KITKAT)
    public static void SendBuffer(final String buf){
        new Thread(new Runnable() {
            public void run() {
                Socket socket;
                try {
                    // 创建一个Socket对象，并指定服务端的IP及端口号
                    socket = new Socket("192.168.1.42", 8080);
                    DataOutputStream outputStream = new DataOutputStream(socket.getOutputStream());
                    //发送图片
                    Bitmap bitmap = BitmapFactory.decodeFile(buf);
                    ByteArrayOutputStream bout = new ByteArrayOutputStream();
                    bitmap.compress(Bitmap.CompressFormat.PNG,100,bout);
                    //写入字节的长度，再写入图片的字节
                    long len = bout.size();
                    //这里打印一下发送的长度
                    Log.e("内容：",bout.toString());
                    outputStream.write((("FILE##")+len+".jpg##"+len+"##").getBytes());
                    outputStream.flush();
                    //发送成功
                    Log.i("ServerReceviedByTcp","outputStream.write ok" );
                    // 发送读取的数据到服务端
                    socket.close();
                    socket = new Socket("192.168.1.42", 8080);
                   outputStream = new DataOutputStream(socket.getOutputStream());
                    //发送图片
                    bitmap = BitmapFactory.decodeFile(buf);

                    bout = new ByteArrayOutputStream();
                    bitmap.compress(Bitmap.CompressFormat.PNG,100,bout);

                    byte[] a = null;
                    a = "CON##".getBytes();
                    byteMerger(a,bout.toByteArray());
//byteMerger(a,bout.toByteArray())
                    outputStream.write(bout.toByteArray());
                    outputStream.flush();
                    //发送成功
                    Log.i("ServerReceviedByTcp","outputStream.write ok" );
                    // 发送读取的数据到服务端
                    socket.close()；

                } catch (UnknownHostException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }).start();
    }
```

**基于UDP的Socket**



## HTTP/HTTPS





## 热修复

热修复就是不需要下载APK的情况下进行补丁安装。

## OKHttp

#### Get请求网络数据

```java
private static final int GET = 1;
private OKHttpClient client = new OKHttpClient();
private Handler handler = new Handler(){
    @override
    public void handleMessage(Message msg){
        super.handleMessage(msg);
        switch(msg.what){
            case GET:			
                text.settext((String)msg.obj);
                //这是在使用get请求的线程中使用的，方法如下
                break;
        }
    }
}
/*Get请求使用方法
	String result = get(url);
	Message msg = Message.obtain();
	msg.what(GET);
	msg.obj = result;
	handler.sendMessage(msg);
*/
//要在主线程接收信息还需要handler接收

//这是一个OKHttp的get请求方法，只能在子线程，不能再主线程
private String get(String url) throw IOException{
	Request request = new Request.Builder() 
					.url(url)
					.build();
	Response response = client.newCall(request).execute();
	return response.body().string();
}
```

### Post请求网络数据

```java
public static final MediaType JSON = MediaType.get("application/json");		//URL地址
private static final int GET = 1;
private static final int POST = 2;
OkHttpClient client = new OkHttpClient();			//post也需要创建client

private Handler handler = new Handler(){
    @override
    public void handleMessage(Message msg){
        super.handleMessage(msg);
        switch(msg.what){
            case GET:			
                text.settext((String)msg.obj);
                //这是在使用get请求的线程中使用的，方法如下
                break;
            case POST:
                break;
        }
    }
}

/*Get请求使用方法
	String result = post(url，Null);  	//第一个是URL，第二个是json，json是上传数据才用得到，所以可以直接设置为Null
	Message msg = Message.obtain();
	msg.what(POST);
	msg.obj = result;
	handler.sendMessage(msg);
*/

private String post(String url, String json) throws IOException {
  RequestBody body = RequestBody.create(json, JSON);
  Request request = new Request.Builder()
      .url(url)
      .post(body)
      .build();
  try (Response response = client.newCall(request).execute()) {
    return response.body().string();
  }
}
```

### JSON解析

JSON是一种轻量级的数据交换格式

特点：

+ 本质就是具有特定格式的字符串
+ JSON完全独立于编程语言
+ JSON比XML数据传输的有效性要高出很多

JSON的两种格式：

+ JSON对象：

  + JSON对象的结构：{KEY:value1,KEY:value2,KEY:value3}
  + **KEY**的数据类型：字符串
  + **value**的数据类型：字符串、数值、null、JSON对象{}，JSON数组{}

+ JSON数组：

  + JSON对象的结构：[value1,value2,value3]
  + **value**的数据类型：字符串、数值、null、JSON对象{}，JSON数组{}

+ JSON析方向

  + Android原生解析

    + 特点：

      + 变成相对麻烦

      + 数据之间转换

        + 将JSON格式的字符串{}转换为Java对象		//安卓提供的原生解析只有将json转换为java，没有将java转换为json

          + JSONObject(String json);	将JSON字符串解析为Java对象

          + 获取到对象后可以通过**get(String name)**和**opt(String name)**方法获得对应的value

          + 使用方法获得value时，如果值为空，get方法会出现异常，但是opt方法会返回一个空字符串或者指定的值

            + ```java
              //将JSON格式的字符串{}转换为Java对象
              //获取或者创建JSON数据
              String json = "{xxxxx}";
              //解析JSON数据
              try{
                  JSONObject jsonobject = New JsonObject(json);
                  //int id = jsonobject.getInt("id");		//两种方法都可以使用
                  //开始解析JSON数据
                  int id = jsonobject.optInt("id");
                  String name = jsonobject.optString("name");
                  Double price = jsonobject.optDouble("price");
                  String imagepath = jsonobject.optString(imagepath);
              }catch(JSONException e){
                  e.printStackTrace();
              }
              ```

        + 将JSON格式的字符串[]转换为Java对象的List

          + JSONArray(String json)	将JSON字符串解析为JSON数组

          + int length();                 得到JSON数组中的元素个数

          + 获取到对象后可以通过**get(String name)**和**opt(String name)**方法获得对应的value

          + ```java
            //将JSON格式的字符串{}转换为Java对象的List
            //获取或者创建JSON数据
            String json = "{xxxxx}";
            //解析JSON数据
            List<ShopInfo> shops = new ArrayList<>();
            
            try{
            	JSONArray jsonarray = new JSONArray(json);
                for(int i = 0; i < jsonarray.length(); i++){
                    JSONObject jsonobject = jsonarray.getJSONObject(i);
                    if(jsonobject != null){
                        int id = jsonobject.optInt("id");
                        String name = jsonobject.optString("name");
                        Double price = jsonobject.optDouble("price");
                        String imagepath = jsonobject.optString(imagepath);
                        //封装java对象
                        ShopInfo shopinfo = new ShopInfo(id,name,price,imagepath);
                        shop.add(shopinfo);
                        
                    }
                }
            }catch(JSONException e){
                e.printStackTrace();
            }
            ```

        + 复杂JSON数据解析

          + ```java
            //复杂JSON数据解析
            //获取或者创建JSON数据
            String json = "{xxxxx}";
            //解析JSON数据,可以使用HiJSON工具进行格式化JSON
            try{
            	JSONObject jsonobject = New JsonObject(json);
                //使用GsonFormat格式化JSON，然后封装对象使用
                DataInfo datainfo = new DataInfo();
                //第一层解析
                JSONObject data = jsonobject.optJSONObject("data");
                String Keyname = jsonobject.optString("Keyname");
                String Value = jsonobject.optString('Value');
                //第一层封装
                datainfo.setRs_code(rs_code);
                datainfo.setRs_nsg(rs_msg);
                Datainfo.DataBean dataBean = new Datainfo.DataBean();
                datainfo.setData(dataBean);
                
                //第二层解析
                int count = data.optInt("count");
                JSONArray items = data.JSONArray("items");
                //第二层封装
                dataBean.setCount(count);
                List<Datainfo.DataBean.ItemsBean> ItemsBean = new ArrayList<>();
                dataBean.setItems(ItemsBean);
                
               	//第三层解析
                for(int i = 0; i < itmes.length; i++){
                    JSONObject jsonobject =  item.optJSONObject(i);
                    if(jsonobject != null){
                        int id = jsonobject.optInt("id");
                        String title = jsonobject.optString("title");
                        //第三层封装
                        DataInfo.DataBean.ItemsBean bean= new DataInfo.DataBean.ItemsBean();
                        bean.setId(id);
                        bean.setTitle(title);
                        ItemsBean.add();
                    }
                }
            }catch(JSONException e){
                e.printStackTrace();
            }
            ```

        + 特殊JSON数据解析

          + ```java
            //特殊JSON数据解析
            //获取或者创建JSON数据
            String json = "{xxxxx}";
            //创建封装的JAVA对象
            FilmInfo filminfo = new FileBean();
            
            try{
            	JSONObject jsonobject = New JsonObject(json);
                //第一层解析
                int code = jsonobject.optInt("code");
                JSONObject list = jsonobject.optJSONObject("list");
                //第一层封装
                FilmInfo.setCode(code);
                List<FilmInfo.FilmBean> lists = new ArrayList<>();
                fileinfo.setList(lists);
                //第二层解析
               	for(int i = 0; i < list.length; i++){
                    JSONObject jsonobject =  list.optJSONObject(i+"");
                    if(jsonobject != null){
                        String aid = jsonobject.optString("aid");
                        String title = jsonobject.optString("title");
                        int coins = jsonobject.optInt("coins");
                        String copyright = jsonobject.optString("copyright");
                        String create = jsonobject.optString("create");
                        //第二层封装
                        FilmInfo.FileBean fileBean = new FilmBean();
                        fileBean.setId(aid);
                        fileBean.setTitle(title);
                        fileBean.setcoins(coins);
                        fileBean.setcopyright(copyright);
                        fileBean.setcreate(create);
                        lists.add(fileBean);
                    }
                }
            }catch(JSONException e){
                e.printStackTrace();
            }
            ```

  + GSON框架技术解析

    + 特点：编码简洁，官方推荐

    + 数据之间转换

      + 将JSON格式的字符串{}转换为Java对象

        + ```java
          /*<T> T fromJSON(String json,Class <T> ClassofT);
          	方法就是fromjson，参数为json字符串和解析json后生称的java的类
          */
          //要求json对象中的key的名称与java对象对应的类中的属性名要相同
          //获取或创建JSON数据
          String json = "xxxxx";
          //创建Gson对象
          Gson gson = new Gson();
          ShopInfo shopinfo = gson.fromjson(json,shopinfo.class);
          ```

      + 将JSON格式的字符串[]转换为Java对象的List

        + ```java
          /* fromjson(String json,Type typeofT)
          	参数为json字符串和
          */
          //获取或创建JSON数据
          String json = "xxxxx";
          //创建Gson对象
          Gson gson = new Gson();
          List<ShopInfo> shops = ShopInfo shopinfo = gson.fromjson(json,new TypeToken<List<ShopInfo>>(){}.getType());
          ```

      + 将JAVA对象转换为json字符串{}

        + ```java
          /* toJson(Object src)
          	传入Java对象
          */
          //获取或创建Java对象
          ShopInfo shopinfo = new ShopInfo(1,"鲍鱼",250.0,"baoyu");
          //生成Json数据
          Gson gson = new Gson();
          String json = gson.toJson(shopinfo);
          ```

      + 将JAVA对象的List转换为json字符串[]

        + ```java
          /* toJson(Object src)
          	传入Java对象
          */
          //获取或创建Java对象
          List<ShopInfo> shopinfo = new ArrayList<>();
          ShopInfo baoyu = new ShopInfo(1,"鲍鱼",250.0,"baoyu");
          ShopInfo longxia = new ShopInfo(2,"龙虾",300.0,"longxia");
          shopinfo.add(baoyu);
          shopinfo.add(longxia);
          //生成Json数据
          Gson gson = new Gson();
          String json = gson.toJson(shopinfo);
          ```

  + FastJson框架技术解析

    + 特点:	FastJson是目前JAVA语言中最快的JSON库

    + 数据之间转换

      + 将JSON格式的字符串{}转换为Java对象

        + ```java
          /* <T> T parseObject(String json, Class<T> ClassOfT)
          	参数：json字符串和转换后生成的对象的类
          	返回值是对象
          */
          //JSON数据
          String json = "xxxxxxxx";
          //调用parseObject方法,获取转换后的Java类
          ShopInfo Shopinfo = JSON.parseObject(json,ShopInfo.class);
          ```
      + 将JSON格式的字符串[]转换为Java对象的List
      
        + ```java
          /* List<T> parseArray(String json,Class<T> classOfT);
          		参数：json字符串和转换后生成的对象的类
          		返回值是集合
          */
          //JSON数据
          String json = "xxxxxxxx";
          //调用parseObject方法,获取转换后的Java类
          List<ShopInfo> shopinfo = JSON.parseArray(json,ShopInfo.class);
          ```
      + 将JAVA对象转换为json字符串{}
      
        + ```java
          /* 
          	toJSONString(Object object);
          */
          //创建JAVA对象
          ShopInfo shopinfo = new ShopInfo(1,"鲍鱼",250.0,"baoyu");
          //调用toJsonString方法
          String json = JSON.toJSONString(shopinfo);
          ```
      + 将JAVA对象的List转换为json字符串[]
      
        + ```java
          /* 
          	toJSONString(Object object);
          */
          //创建JAVA对象
          List<ShopInfo> shops = new List<>();
          ShopInfo baoyu = new ShopInfo(1,"鲍鱼",250.0,"baoyu");
          ShopInfo longxia = new ShopInfo(2,"龙虾",400.0,"longxia");
          shops.add(baoyu);
          shops.add(longxia);
          String json = JSON.toJSONString(shops);
          ```

## CountDownLatch可以使一个获多个线程等待其他线程各自执行完毕后再执行。