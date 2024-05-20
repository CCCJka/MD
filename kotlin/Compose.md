## Compose中获取Context

```kotlin
val context = LocalContext.current as Activity //这样做可能会有安全隐患

//google官方例子有这样一个方法
/**
 * Find the closest Activity in a given Context.
 */
fun Context.findActivity(): Activity {
    var context = this
    while (context is ContextWrapper) {
        if (context is Activity) return context
        context = context.baseContext
    }
    throw IllegalStateException("Permissions should be called in the context of an Activity")
}
//使用方法
val context = LocalContext.current
val activity = context.findActivity()
```



## Modifie的作用

原生开发中我们使用xml在布局中去设置一个控件的大小，间距，点击事件，宽高，背景等属性值。而在Compose中我们是通过Modifie去设置，Modifie相当于一个控件的属性配置的工具类。修饰符大概有如下几种作用

- 第一：可以去更新可组合项的大小，布局，行为和外观。
- 第二：添加互动。例如点击，滚动，可拖拽，缩放等。
- 处理用户输入
- 添加信息，如无障碍标签

## Compose有3哥基本标准布局元素，分别为Column，Row，Box可组合项

+ **<font color = "yellow" >Box</font>**类似与framLayout布局

+ **<font color = "yellow" >Column</font>**为竖直布局，类似与LinearLayout的vertical布局

  + Column的**verticalArrangement**排序方式有以下方式，默认为Arrangement.Top，可以通过**Arrangement.spacedBy()**进行设置，详情可看Column源码

    + **Arrangement.Top** 垂直放置子对象，使其尽可能靠近主轴顶部。
    + **Arrangement.BOTTOM** 垂直放置子对象，使其尽可能靠近主轴底部。
    + **Arrangement.CENTER** 垂直子对象，使其尽可能靠近主轴的中间。
    + **Arrangement.SpaceBetween** 第一个在最顶部，最后一个在最底部。而中间的按同等间隔去均分放置。
    + **Arrangement.SpaceEvenly** 垂直放置子对象，使他们同等间隔均分放置
    + **Arrangement.SpaceAround** 垂直放置子对象，第一个放置在距离顶部x间隔的地方，最后一个放置在距离底部x间隔的地方。中间的按同等间距均分放置。

  + **horizontalAlignment** 表示是水平方向上的对齐方式。默认是从左边开始

  + 在Compse中，Column完整写法如下

    ```kotlin
    //完整写法
    Column(
    	content = (
    		Text("test")
    	)
    )
    //但Compose是支持在kotlin中使用lambda语句的，所以才显示为
    Column(
    	Text("test")
    )
    ```

    

+ **<font color = "yellow" >Row</font>**为横向布局，多项控件水平放置在屏幕上，和Column一样支持包含元素的对齐方式

+ **<font color = "yellow" >Surface</font>**是Jetpack Compose的基本构建块之一。它是一个提供可视化空间以及处理**高程**、**形状**和**边界**的组件。Surface可以控制**阴影、边框、形状和背景色**等元素的视觉效果。

```kotlin
@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
	Column(verticalArrangement = Arrangement.Center,modifier = modifier) {
        Text(
            text = "Happy Birthday Leslie!",
            fontSize = 100.sp,
            lineHeight = 116.sp,
            textAlign = TextAlign.Center	//TextAlign
        )
        Text(
            text = "from $name",
            fontSize = 36.sp,
            modifier = Modifier.padding(16.dp).align(alignment = Alignment.End)	//modifier
        )
    }
```

## Layout

## Compose添加图片

Android 设备具有不同的屏幕尺寸（手机、平板电脑和电视等），而且这些屏幕也具有不同的像素尺寸。也就是说，有可能一部设备的屏幕为每平方英寸 160 个像素，而另一部设备的屏幕在相同的空间内可以容纳 480 个像素。如果不考虑像素密度的这些变化，系统可能会按比例缩放图片，这可能会导致图片模糊或占用大量内存空间，或者图片大小不当。

如果所调整的图片超出了 Android 系统可处理的图片大小，系统会抛出内存不足错误。对于照片和背景图片，应将其放在 `drawable-nodpi` 文件夹中，这样会停止调整大小行为。

```kotlin
val image = painterResource(R.drawable.xxx)
Box{
   Image(
	     painter = image,
         contentScale = ContentScale.Crop,	//image属性，将图片保持宽高进行缩放
		alpha = 0.5F					//图片不透明度
         contentDescription = null
}
```

### 硬编码字符串现已替换为对 `getString()` 函数的调用。

**注意**：某些 Android Studio 版本会将硬编码字符串替换为 `getString()` 函数。在这种情况下，请将函数手动更改为 `stringResource()`。

## 强制转换

toXXXorNull为kotlin预定义函数，函数是将字符串解析为xxx并返回结果，如果不是有效的数据则返回null，例如:

+ **toDoubleOrNull()**函数会将字符串解析为 `Double` 数字并返回结果，而如果字符串不是有效的数字表示法，该函数会返回 **null**。
+ **toIntOrNull**
+ **toFloatOrNull**

## TextField文本输入框

主要属性
+ **<font color = "yellow" >value</font>** 形参是一个文本框，用于显示您在此处传递的字符串值。
+ **<font color = "yellow" >onValueChange</font>** 形参是用户在文本框中输入文本时触发的 lambda 回调。

Android 提供了一个选项，用于配置屏幕上显示的键盘，以便输入数字、电子邮件地址、网址和密码等内容。

+ 将键盘类型设置为数字键盘即可输入数字。向 `KeyboardOptions` 函数传递设置为 `KeyboardType.Number` 的 `keyboardType` 具名形参：

## SnackBar

## Scaffold

Scaffold在我的理解是一个按钮或者布局容器，可以用来创建一个标准布局，他的构造函数有很多，只需要挑选需要的就行创建即可，官方范例如下：

```kotlin
val scope = rememberCoroutineScope()	//snackBar的显示隐藏需要使用此函数
    val snackbarHostState = remember { SnackbarHostState() }	//记住snackBar的状态
    Scaffold(
        snackbarHost = {
            SnackbarHost(hostState = snackbarHostState)
        },
        floatingActionButton = {		//创建一个悬浮按钮
            ExtendedFloatingActionButton(
                text = { Text("Show snackbar") },	//Button显示文本
                icon = { Icon(Icons.Filled.Share, contentDescription = "") },
                onClick = {
                    scope.launch {	//snackBar需要和此函数搭配使用
                        snackbarHostState.showSnackbar("Snackbar")	//点击按钮后产生的SnackBar的文本
                    }
                }
            )
        }
    ) { contentPadding ->
        TipTimeLayout()
        Box(modifier = Modifier.padding(contentPadding))
    }
```

<font color = "yellow" >remember对key的变化监听,只接受赋值。</font>



## WebView范例

```kotlin
@Composable
fun webviewTest(modifier: Modifier = Modifier,
                url:String,
                onBack: (webView: WebView?) -> Unit,
                onProgressChange: (progress:Int)->Unit = {},
                initSettings: (webSettings: WebSettings?) -> Unit = {},
                onReceivedError: (error: WebResourceError?) -> Unit = {}){
    val webViewChromeClient = object: WebChromeClient(){
        override fun onProgressChanged(view: WebView?, newProgress: Int) {
            //回调网页内容加载进度
            onProgressChange(newProgress)
            super.onProgressChanged(view, newProgress)
        }
    }
    val webViewClient = object: WebViewClient(){
        override fun onPageStarted(view: WebView?, url: String?,
                                   favicon: Bitmap?) {
            super.onPageStarted(view, url, favicon)
            onProgressChange(-1)
        }
        override fun onPageFinished(view: WebView?, url: String?) {
            super.onPageFinished(view, url)
            onProgressChange(100)
        }
        override fun shouldOverrideUrlLoading(
            view: WebView?,
            request: WebResourceRequest?
        ): Boolean {
            if(null == request?.url) return false
            val showOverrideUrl = request.url.toString()
            try {
                if (!showOverrideUrl.startsWith("http://")
                    && !showOverrideUrl.startsWith("https://")) {
                    //处理非http和https开头的链接地址
                    Intent(Intent.ACTION_VIEW, Uri.parse(showOverrideUrl)).apply {
                        addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        view?.context?.applicationContext?.startActivity(this)
                    }
                    return true
                }
            }catch (e:Exception){
                //没有安装和找到能打开(「xxxx://openlink.cc....」、「weixin://xxxxx」等)协议的应用
                return true
            }
            return super.shouldOverrideUrlLoading(view, request)
        }

        override fun onReceivedError(
            view: WebView?,
            request: WebResourceRequest?,
            error: WebResourceError?
        ) {
            super.onReceivedError(view, request, error)
            //自行处理....
            onReceivedError(error)
        }
    }
    var webView:WebView? = null
    val coroutineScope = rememberCoroutineScope()
    AndroidView(modifier = modifier,factory = { ctx ->
        WebView(ctx).apply {
            this.webViewClient = webViewClient
            this.webChromeClient = webViewChromeClient
            //回调webSettings供调用方设置webSettings的相关配置
            initSettings(this.settings)
            webView = this
            loadUrl(url)
        }
    })
    BackHandler {
        coroutineScope.launch {
            //自行控制点击了返回按键之后，关闭页面还是返回上一级网页
            onBack(webView)
        }
    }
}
```

```kotlin
val context = LocalContext.current as Activity //这样做可能会有安全隐患
val TAG = WebViewActivity::class.qualifiedName  //获取类名
//webView使用
webviewTest(modifier = Modifier.fillMaxSize(),
            url = "https://www.baidu.com/",
            initSettings = {settings->
                settings?.apply {
                    //支持js交互，此项类似java中的WebSettings
                    javaScriptEnabled = true
                    //....
                }
            }, onBack = { webView ->
                //可根据需求处理此处
                if (webView?.canGoBack() == true) {
                    //返回上一级页面
                    webView.goBack()
                } else {
                    //关闭activity
                    context.finish()
                }
            },onReceivedError = {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    Log.d(TAG,">>>>>>${it?.description}")
                }
            })
```



## Dialog以及AlertDialog

```kotlin
@Composable
fun dialogTest(showDialog: () -> Unit){
    val context = LocalContext.current as Activity	//将context转换为Activity
        AlertDialog(
            onDismissRequest = { /*TODO*/ },
            text = { Text(text = "请确认是否退出") },
            dismissButton = {
                Button(onClick = showDialog) {
                    Text(text = "取消")
                }
            },
            confirmButton = {
                Button(
                    onClick = { context.finish() }
                ) {
                    Text(text = "确认")
            }
        }
    )
}

//使用
dialogTest{ showDialog = !showDialog }
```



## 注解

使用 `@StringRes` 注解为该函数形参或变量添加注解，指明形参应为字符串资源引用，例如

```kotlin
@Composable
fun Example(@StringRes strId: Int){
    TextField(
        strId = R.id.exampleIcon
    )
}
```

使用 `@DrawableRes` 注解为控件添加前置图标，指明该形参或变量可作为drawble资源引用，例如

```kotlin
@Composable
fun Example(@DrawableRes drawableId: Int){
    TextField(
		leadingIcon = { Icon(painter = painterResource(id = drawableId), null) },
    )
}
```



## kotlin通配符

```kotlin
//通配符在类中使用应写在类名后，在方法中使用应写在方法名前
fun <T>navigation(context: Context, className: Class<T>){
    context.startActivity(Intent(context, className))
}
```



# Android控件在kotlin使用方法

### DatePickerDialog

```kotlin
private var selectedYear = 0
private var selectedMonth = 0
private var selectedDay = 0
val calendar: Calendar = Calendar.getInstance()

fun showCalendarDialog(){
    var year = calendar.get(Calendar.YEAR)
    var month = calendar.get(Calendar.MONTH)
    var day = calendar.get(Calendar.DAY_OF_MONTH)

    val listener = DatePickerDialog.OnDateSetListener { datePicker, selectedYear, selectedMonth, selectedDay ->
        year = selectedYear
        month = selectedMonth
        day = selectedDay
    }

    // create picker
    val datePicker = DatePickerDialog(this, listener, year, month, day)
    datePicker.show()    
}

//Compose则只需要将dataPicker作为参数传入即可
override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    	setContent {
        ExampleTheme {
            showCalendarDialog(datePicker)
        }
    }
}
@Composable
fun showCalendarDialog(datePicker: DatePickerDialog){
    Button(onClick = { /*TODO*/ }) {
            Text(text = "日历")
        }
}
```

