```dart
import 'dart:io';

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
  
  //类似构造函数，创建对象时需要提供title属性
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
        color: Colors.red,
        child: Column(    //
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                Text("首页",
                style: Theme.of(context) //
                    .primaryTextTheme
                    .titleLarge),
                Text('You have pushed the button this many times:'),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ElevatedButton(
                  onPressed: () {
                    //创建flutter自带的SnackBar提示框并显示
                    final snackBar = SnackBar(content: Text("testing"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    isChangeText = !isChangeText;
                    setState(() {   //需要更改状态才能动态修改文本内容，使用changeText = "xxx"无法修改内容
                      changeText = isChangeText ? "changeText" : "testing";
                    });
                  },
                  child: Text('Next'),  //ElevatedButton的文本
                ),
                Text(changeText),
          ]),
      ),
      Container(color: Colors.green),
      Container(color: Colors.blue),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
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
            Icon(Icons.plus_one)
          ],
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

```

