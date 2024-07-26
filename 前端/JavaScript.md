```html
HTML 中的 Javascript 脚本代码必须位于 <script> 与 </script> 标签之间。
Javascript 脚本代码可被放置在 HTML 页面的 <body> 和 <head> 部分中。
```

## <script>标签

```html
如需在 HTML 页面中插入 JavaScript，请使用 <script> 标签。
<script>
alert("我的第一个 JavaScript");
</script>
```

在body中使用script则会在body加载时写入信息

```html
<!DOCTYPE html>
<html>
<body>
<script>
document.write("<h1>这是一个标题</h1>");
document.write("<p>这是一个段落</p>");
</script>
</body>
</html>
```

js函数写法如下

如果需要访问某个html元素，则可以通过 **document.getElementById(*id*) **

```html
<script>
function myFunction(){
    document.getElementById("demo").innerHTML="我的第一个 JavaScript 函数";
}
</script>
<!-- 使用方法如下 -->
<p id="demo">一个段落</p>	<!-- 将该段落id命名为demo，并在js函数中指定该段落，也就是document.getElementById("demo") -->
<button type="button" onclick="myFunction()">尝试一下</button>	<!-- 使用onclick指定方法，点击后及那个id为demo的段落修改为函数指定的文字 -->
```

<font color = "yellow">js函数通常可以放在head、body或者作为外部文件引用， 当作为外部文件进行引用时写法如下</font>

```html
<script src="myScript.js"></script>
```

<font color="yellow">当作为外部文件时，不可使用<script>标签 </font>



## JS显示数据

- 使用 **window.alert()** 弹出警告框。

```html
  <script>
  window.alert(5 + 6);
  </script>
```
- 使用 **document.write()** 方法将内容写到 HTML 文档中。

```html
<script>
document.write(Date());
</script>
```
- 使用 **innerHTML** 写入到 HTML 元素。

```html
<!-- 使用innerHTML需要注意将需要访问的元素进行命名 -->
<script>
document.getElementById("demo").innerHTML = "段落已修改。";
</script>
```
- 使用 **console.log()** 写入到浏览器的控制台。

```html
<!-- 如果浏览器支持调试，可以通过开发者模式(F12)进行日志查看 -->
<script>
a = 5;
b = 6;
c = a + b;
console.log(c);
</script>
```

在JS中，固定值被称为**字面量**

```javascript
<!-- 数字（Number）字面量 可以是整数或者是小数，或者是科学计数(e) -->
如3.14	1001	123e5
<!-- 字符串（String）字面量 可以使用单引号或双引号 -->
"John Doe"		'John Doe'
<!-- 表达式字面量 用于计算 -->
5 + 6		5 * 10
<!-- 数组（Array）字面量 定义一个数组 -->
[40, 100, 1, 5, 25, 10]
<!-- 对象（Object）字面量 定义一个对象 -->
{firstName:"John", lastName:"Doe", age:50, eyeColor:"blue"}
<!-- 函数（Function）字面量 定义一个函数 -->
function myFunction(a, b) { return a * b;}
<!-- JavaScript 使用关键字 var 来定义变量， 使用等号来为变量赋值 -->
var x
<!-- JavaScript数据类型 -->
var length = 16;                                  // Number 通过数字字面量赋值
var points = x * 10;                              // Number 通过表达式字面量赋值
var lastName = "Johnson";                         // String 通过字符串字面量赋值
var cars = ["Saab", "Volvo", "BMW"];              // Array  通过数组字面量赋值
var person = {firstName:"John", lastName:"Doe"};  // Object 通过对象字面量赋值
//值类型(基本类型)：字符串（String）、数字(Number)、布尔(Boolean)、空（Null）、未定义（Undefined）、Symbol。
//引用数据类型(对象类型)：对象(Object)、数组(Array)、函数(Function)，还有两个特殊的对象：正则（RegExp）和日期（Date）。
//查看数据类型可使用typeof进行查看，例如
typeof "test"	//返回String
```

