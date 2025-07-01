## Flutter 关键字

flutter有一个关键字需要注意，**late**

```dart
//late关键字为允许变量不初始化，在需要时才进行初始化即可，与kotlin的lateinit用法相似
late int lateInitNumber;
print("print = $lateInitNumber");	//出现错误,提示变量未初始化
lateInitNumber = 10;
print("print = $lateInitNumber");	//print = 10
```



## 添加布局

Flutter的App就是一个复合Widget构成的

- 一个 `child` 属性，如果它们只包含一个子项 —— 例如 `Center` 和 `Container`
- 一个 `children` 属性，如果它们包含多个子项 —— 例如 `Row`、`Column`、`ListView` 和 `Stack`

### Widget对齐方式

水平行对齐

**mainAxisAlignment**:	类似LinearLayout的horizontal

垂直对齐

**crossAxisAlignment**： 类似LinearLayout的vertical



```dart
//在点击事件中，如果函数需要传参可以使用匿名函数，参考以下写法
onTap:() => function(true)
//或
onTap:() {
    function(true)
}
```





```dart
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Main View')
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  //类似构造函数，使用required表示在创建对象时需要提供title属性
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  int _counter = 0;
  String changeText = "testing";
  bool isChangeText = false;
  late TabController _tabController;

  int currentIndex = 0;

  final snackBar = SnackBar(
    content: Text("click next"),
    action: SnackBarAction(   //撤销
      label: "undo",
       onPressed: (){
        print("undo Setting");  //点击撤销后执行的操作
    }),);

  final List<BottomNavigationBarItem> navigationBar  = [BottomNavigationBarItem(icon: Icon(Icons.star), label: "star"),
    BottomNavigationBarItem(icon: Icon(Icons.public), label: "public"), 
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "maximize")];

  final List<String> scrollerView = ["Sdvdav", "a飒飒v", "而微软很容易", "微软不会特", "而不死", "只需色", "Bert在", "(⊙﹏⊙)旋转", "qrwerg", "阿凡达三百1", "1阿斯顿吧VS", "啊打发1",
               "阿斯顿VS挺好", "甚至v我", "你还要让他", "uKiki是", "阿迪王", "全额发放v投入费用", "是造成干扰", "安慰副区长", "在v热", ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //类似Compose的声明式UI，flutter使用Widget来标明该函数为UI组件
  Widget getTabBar() {
    return TabBar(controller: _tabController, tabs: [
      Tab(text: "首页", icon: Icon(Icons.home)),
      Tab(text: "编辑", icon: Icon(Icons.edit)),
      Tab(text: "设置", icon: Icon(Icons.settings)),
    ]);
  }

  Widget getTabBarPages() {
    return TabBarView(controller: _tabController, children: <Widget>[
       //创建TabController的显示内容
      Container( 
        color: Color.fromARGB(255, 57, 116, 125),
        child: mainPageContainer(),
      ),
      Container(
        color: Color.fromARGB(255, 190, 182, 106),
        child: editPageContainer(),
      ),
      Container(color: Colors.black),
    ]);
  }

  Widget mainPageContainer(){
    return Column(    //
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                Text('You have pushed the button this many times:'),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    isChangeText = !isChangeText;
                    setState(() {   //需要更改状态才能动态修改文本内容，使用changeText = "xxx"无法修改内容
                      changeText = isChangeText ? "changeText" : "testing";
                    });
                     //创建flutter自带的SnackBar提示框并显示
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Text('Next'),  //ElevatedButton的文本
                ),
                Text(changeText),
              ]
          );
  }

  Widget editPageContainer(){
    return Scrollbar(   
            child: Center(
              child: ListView.builder(
                itemCount: scrollerView.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: Text(scrollerView[index]),
                    textColor: Colors.black,
                    selected: true,
                    onTap: () => clickItem(scrollerView[index])
                    );
                },
              )
            ),

          );
  }

  void clickItem(String index){
    var clickShowSnack = SnackBar(content: Text(index));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(clickShowSnack);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // title: Text(widget.title),
          centerTitle: true,
          flexibleSpace: SafeArea(
            child: getTabBar(),
          ),
        ),
        body: getTabBarPages(),
        floatingActionButton: FloatingActionButton(   //右下角悬浮窗点击后中间数字+1
        onPressed: _incrementCounter,   //点击产生的效果
        tooltip: 'focus hint',           //鼠标悬浮在图标上方时显示的提示
        backgroundColor: const Color.fromARGB(255, 10, 76, 130),  //默认背景颜色
        hoverColor: const Color.fromARGB(109, 87, 230, 237),  //悬浮  在控件上的颜色
        splashColor: Colors.red,        //点击变换的颜色
        focusElevation: 50,
        hoverElevation: 50,            //按钮下方的阴影大小
        highlightElevation: 50,
        disabledElevation: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.add)
          ],
        )
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: navigationBar,
        onTap: onTabChanged), 
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onTabChanged(int value) {
    currentIndex = value;
    print("currentIndex = $currentIndex");
    setState(() {});
  }
}


Widget imageWidget(String imagePah){ //创建一个widget控件
 return Image.asset(
    imagePah,
    fit: BoxFit.cover,
  );
  //或者使用Icon
  /**
   * Icon(
   *  Icons.star,
   *  color: Colors.red[500],
   * ),
   */
}

```

