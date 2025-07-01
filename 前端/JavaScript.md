```html
HTML 中的 Javascript 脚本代码必须位于 <script> 与 </script> 标签之间。
如果使用script标签时引用外部文件，那么在标签内不可编写方法以及变量
Javascript 脚本代码可被放置在 HTML 页面的 <body> 和 <head> 部分中。
```

## <script>标签

```html
如需在 HTML 页面中插入 JavaScript，请使用 <script> 标签。
<script>
alert("我的第一个 JavaScript");
</script>
```

## DOM：Document Object Model

使用全局变量Document

在body中使用script则会在body加载时写入信息，不可在最后使用write，这样会覆盖文档，将页面元素修改为写入的内容

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

innerText以及innerHtml

```javascript
//使用innerText时无法在写入的内容中插入元素
document.getElementById("xxx").innerText = "写入的内容，<p>无法写入元素</p>"
//使用innerHtml时可在内容中插入新增的元素
document.getElementById("xxx").innerHtml = "写入的内容，<p>写入元素成功</p>"
```

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
<!-- 也可以在onclick中编写代码，例如 -->
<button type="button" onclick="document.getElementById('demo').innerHTML='修改后的文字'"
```

<font color = "yellow">js函数通常可以放在head、body或者作为外部文件引用， 当作为外部文件进行引用时写法如下</font>

```html
<script src="myScript.js"></script>
```

```html
<button type="button" onclick="changeText(this)">点击</button></button>	<!-- this为该元素 -->
<script>
    function changeText(id){id.innerHTML = "修改文本"}	//修改指定id的文本
</script>
```



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

## onmouseover、onmouseout、onmouseup、onmousedown

鼠标在目标元素时的操作，例如

```html
<div onmouseover="mouseOver(this)" onmouseout="mouseOut(this)">鼠标操作</div>
<div onmouseup="mousseUp(this)" onmousedown="mouseDown(this)">鼠标点击元素操作</div>
<script>
	function mouseOver(obj){obj.innertHTML="鼠标位于元素上"}
    function mouseOut(obj){obj.innerHTML="鼠标移开该元素"}
    function mousseUp(obj){obj.innerHTML="鼠标点击后松开"}
    function mouseDown(obj){obj.innerHTML="鼠标点击"}
</script>
```

### 元素监听

```html
<button id="xxxx">click</button>
<p id="demo"></p>
<script>
    function displayData(){
        document.getElementById("demo").innerTEXT = Data();
    }
    document.getElementById("xxxx").addEventListener("click", displayDate);	//click可为各类函数，例如onmouseout
</script>
```

### 事件冒泡和事件捕获

事件冒泡

+ 在冒泡中，内部元素的事件会先被触发，然后再触发外部元素，即： <p> 元素的点击事件先触发，然后会触发 <div> 元素的点击事件。

事件捕获

+ 在捕获中，外部元素的事件会先被触发，然后才会触发内部元素的事件，即： <div> 元素的点击事件先触发 ，然后再触发 <p> 元素的点击事件。

### 代码添加新元素

appendChild()：要创建新的 HTML 元素 (节点)需要先创建一个元素，然后在已存在的元素中添加它。该函数创建的元素位于父元素的尾部

insertBefore()：该函数创建的元素位于父元素的头部

removeChild()：该函数可移除指定元素

replaceChild()：该函数可替换指定元素

```html
<div id="parent">
	<p id="p1"></p>
</div>

<script>
    let endElement = document.createElement("ep");
    let endNode = document.createTextNode("这是一个新建的尾部段落。");
    endElement.appendChild(endNode);	//将文本添加到新创建的尾部元素
	
    let startElement = document.createElement("sp");
    let startNode = document.createTextNode("这是一个新建的头部段落")
    startElement.appendChild(startNode);	//将文本添加到新创建的头部元素
	
    var element = document.getElementById("parent");
	var p1 = document.getElementById("p1");
    element.appendChild(endElement);
    element.insertBefore(startElement, p1);	//将元素添加到指定元素的头部
    
    element.removeChild(startElement);		//删除新创建的startElement元素
    element.replaceChild(startElement, p1)	//将指定元素替换
</script>
```

## HTMLCollection

getElementByTagName()返回一个HTMLCollection对象,例如getElementByTagName("p")会返回一个所有p标签的对象

HTMLCollection有 **length** 属性，该属性为对象的长度

HTMLCollection并非为一个数组，但他可以向数组一样使用索引获取长度，但无法使用数组的方法： valueOf(), pop(), push(), 或 join() 

## NodeList

```html
<script>
    var list = document.querySelectorAll("p");
    list[0].style.background-color = "red"	//将list中的0位元素修改背景为红色
</script>
```

**NodeList** 对象是一个从文档中获取的节点列表 (集合) 。NodeList 对象类似 HTMLCollection 对象。

## HTMLCollection于NodeList的区别

HTMLCollection 元素可以通过 name，id 或索引来获取，NodeList 只能通过索引来获取。只有 NodeList 对象有包含属性节点和文本节点。



## BOM：Browser Object Model

```
所有浏览器都支持 window 对象。它表示浏览器窗口。
所有 JavaScript 全局对象、函数以及变量均自动成为 window 对象的成员。
全局变量是 window 对象的属性。
全局函数是 window 对象的方法。
甚至 HTML DOM 的 document 也是 window 对象的属性之一：
window.document.getElementById("header") 于 document.getElementById("header") 相等
```

## Window 尺寸

有三种方法能够确定浏览器窗口的尺寸。

对于Internet Explorer、Chrome、Firefox、Opera 以及 Safari：		对于 Internet Explorer 8、7、6、5：					或者

- window.innerHeight - 浏览器窗口的内部高度(包括滚动条)			document.documentElement.clientHeight		document.body.clientHeight
- window.innerWidth - 浏览器窗口的内部宽度(包括滚动条)             document.documentElement.clientWidth          document.body.clientWidth

## 其他 Window 方法

- window.open() - 打开新窗口
- window.close() - 关闭当前窗口
- window.moveTo() - 移动当前窗口
- window.resizeTo() - 调整当前窗口的尺寸

## window.screen 对象在编写时可以不使用 window 这个前缀。

- screen.availWidth - 可用的屏幕宽度
- screen.availHeight - 可用的屏幕高度

## Location

window.location 对象用于获得当前页面的地址 (URL)，并把浏览器重定向到新的页面。

- location.hostname 返回 web 主机的域名
- location.pathname 返回当前页面的路径和文件名
- location.port 返回 web 主机的端口 （80 或 443）
- location.protocol 返回所使用的 web 协议（http: 或 https:）
- location.href 属性返回当前页面的 URL。
- location.assign() 方法加载新的文档。
