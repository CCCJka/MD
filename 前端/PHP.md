## PHP 基本语法

变量明明需要使用**$**开头来命名， 无需声明数据类型。且变量可以在后续更改类型，这点与JavaScript类似

PHP在行末结尾需要使用分号

PHP使用字符串拼接的符号不是使用 **+** ，而是使用符号 **.** 来进行拼接

```php
//Example
$append = "append";
$str = "Str";
$result = $appedn.$str;	//输出 append Str
```

## PHP常量

1. **不变性**: 常量一旦定义，其值不能改变。
2. **全局作用域**: 常量在定义后，可以在整个脚本的任何地方使用，无需使用 **global** 关键字。
3. **数据类型**: 常量的值可以是标量数据类型（如布尔值、整数、浮点数、字符串）或数组（PHP 7 及以上版本）。
4. **区分大小写**: 常量名称默认是区分大小写的。如果需要定义大小写不敏感的常量，可以在 `define()` 函数的第三个参数设置为 true

定义常量有两种方式，使用 **define** 函数以及使用 **const** 进行定义常量

```php
/**
该函数有三个参数:name: 必选参数，常量名称，即标志符	value: 必选参数，常量的值	
case_insensitive: 可选参数，如果设置为 TRUE，该常量则大小写不敏感，默认是大小写敏感的
**/
//使用define进行常量定义
define("defineConst", "输出字符串");
//使用const进行定义
const DEFINECONST = "输出字符串";
```

## PHP函数

**echo**	输出数据，类似print但是用途比print多

```php
// Example
$echoNum = 1;
echo $echoNum;	//输出1
echo "print Str"; //输入print Str
```

**is_dir (filePath)** 判断给定的路径是否为文件夹

**is_file (filePath)** 判断给定路径是否为文件，与is_dir相同

**file_exit(filePath)** 文件是否存在

```php
//Example
$path = "C:\\Users\\";
echo is_dir($path);		//输出1
echo is_file($path); 	//输出空字符串
```

## 魔术常量

```php
$file = __FILE__;	//当前文件的绝对路径
$dir = __DIR__;		//当前文件的父目录
$line = __LINE__;	//文件中的当前行号
$functionName = __FUNCTION__ //返回函数名称
$class = __CLASS__ //返回类名
```

## 获取请求参数

$_GET['xxx']	: 获取到请求时携带的参数，参数于请求的参数名一致

$_POST ['xxx']	:	获取到请求时携带的参数，参数于请求的参数名一致



## 其他

**DIRECTORY_SEPARATOR**	：	目录分隔符，由于系统的不同，分隔符也不同，所以使用该常量能避免由于分隔符不同导致的问题

**date()**	：	时间格式化函数， 如果没有时间参数,则使用当前时间. 格式是一个字符串。	Example：**date("Y-m-d H:i:s ") **

**trval()**	：	 函数用于获取变量的字符串值。





