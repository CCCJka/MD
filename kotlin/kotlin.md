# Kotlin：

代码语句结尾不加分号，与JAVA不同

在kotlin中，使用的不是void，而是Unit

```
Kotlin中T.()->Unit 、(T) -> Unit 、()->Unit
这三个都是函数，返回值为unit，可以返回其他值，这里返回Unit只是为了方便理解
T.()->Unit：函数体中可以直接使用T代表的对象，即用this访问T代表的对象。
(T) -> Unit：将T表示的对象作为实参通过函数参数传递进来，函数体中可以通过参数来访问T代表的对象。
() -> Unit：和T表示的对象没有直接联系，就是一个普通的函数，没有参数。
```

#### 函数

```kotlin
//顺序  修饰符->函数声明关键字->函数名->(参数)->返回类型
//不特别标注的话默认修饰为public
private fun main(age : Int, flag : Boolean) : String{
    return "return"
}
 
//kotlin可以给参数一个默认缺省值，在没有传入数值时会使用缺省值，例如
private fun main(age : Int = 2, flag : Boolean) : String{
    return "return"
}

//kotlin中的Unit相当于java中的void
private fun main(age : Int = 2, flag : Boolean)

//kotlin支持特殊符号作为函数名，使用反引号命名,可以避免关键字冲突类似
Java.`is`
```

#### 匿名函数

```kotlin
//匿名函数可以用来给标准库的函数制定规则，例如返回数据
val total = "TestData".count({letter -> letter == 's'})
//匿名函数的函数类型和隐式返回
//变量的类型是一个匿名函数，返回一个字符串，一般不写return，默认最后一行作为返回的数据
val function : () -> String = {
    val str = "world"
    "hello $str"
}
//函数参数
val function : (String) -> String = { name ->
    val str = "world"
    "$name,hello $str"
}
function("Test");
//it关键字，当只有一个参数时可以使用,一个以上就不能使用了
val function : (String) -> String = { //这里会默认有it，可以不用写name ->
    val str = "world"
    "$name,hello $str"
}
function("Test");
//匿名函数的类型推断，没有参数的例子
val function = {
    val str = "world"
    " hello $str"
} 
//需要参数的例子
val function = {name:String ->
    val str = "world"
    "$name,hello $str"
}
function("Test")
//将函数作为参数
val test = {name:String ->
    val str = "world"
    "$name,hello $str"
}
fun function(name:String,test(name:String)->String){
    val str = "world"
    "$name,hello $str"
}
function("Test",test);
//简略写法，当作为最后一个参数或者作为唯一的参数时可以使用
fun function(name:String,test(name:String)->String){
    val str = "world"
    "$name,hello $str"
}
function("Test"){name:String ->
    val str = "world"
    "$name,hello $str"
}
//函数引用，除了lambda表达式可以将函数作为参数之外还有其他方式可以将函数作为参数使用
fun main(){
    showOnBoard("张三",::getDiscountWords)//使用两个分号也可以将函数作为参数使用
    								  //使用lambda表达式的地方都可以使用函数引用
}
private fun getDiscountWords(goodName: String.hour: Int):String{
    val currentYear = 2027
    return "${currentYear}年，双11${goodName}促销倒计时: $hour 小时
}
private fun showOnBoard(goodsName:String, getDiscountWords:(String,Int) -> String){
    val hour = (1...24).shuffled().last()
    println(getDiscountWords(goodsName,hour))
}
//函数类型作为返回类型，也就是定义一个可以返回函数的函数
fun main(){
    val getDiscountWords = configDiscountWords()
    printf(getDiscountWords("张三"))
}
fun configDiscountWords():(String) -> String{
    val currentYear = 2027
    val hour = (1...24).shuffled().last()
    return {goodsName : String ->
       	"${currentYear}年，双11${goodsName}促销倒计时：$hour 小时"
    }
}
```

#### 闭包：
在kotlin 中，匿名函数能修改并引用定义在自己的作用域之外的变量，匿名函数引用着定义自身的函数里的变量，kotlin中的lambda就是闭包
能接收函数或者返回函数的函数又叫做高级函数，高级函数广泛引用于函数式编程当中

#### lambda与匿名内部类:
函数类型能少些模式化代码，写出更灵活的代码。java8支持面向对象编程和lambda表达式，但不支持将函数作为参数传给另一个函数或变量，不过java的替代方案是匿名内部类

#### 声明变量：

```kotlin
//var代表可读可改
var	变量名 : 数据类型 = "xxx"
//val代表只读的变量，但并不是常量 
val	变量名 : 数据类型 = "xxx"
//const作为局部变量的修饰符时会报错，因为在kotlin中const不适用局部变量
const val 变量名 = "xxx"
//字符类型的声明，需要用单引号
val char : Char = '0'
//布尔类型声明 两种声明方法均可用
val isBool : boolean = false
val isbool = false
//字符串声明
val str : String = "123456"
//访问字符串的元素	0即str字符串的第一位
val strNumber : Char=str[0]
```

#### 内置数据类型：

```
与JAVA相似，但在JAVA中是Integer，kotlin是Int
同时在Kotlin中没有基础数据类型，都转化为引用数据类型了
```

#### 类型推断：

```kotlin
val 变量名 = "xxx"
//类型推断可以根据后面的值判断变量的数据类型，而不用在创建变量的时候写数据类型
```

```kotlin
//字符串的模板表达式
val str : String = "123456"
println("String is $str");		//打印字符串
println("String is ${str.length}");	//打印字符串的长度
val price = "${'$'}9.99"	//$符号转义
print("add" + str + "finish"); //字符串的连接与java相同，直接加号连接即可
val str = "{\"key\":\"value\"}"//转义与Java相似，直接使用\反斜杠进行转义
//""" 分解符，当想用转义符时可以用分解符进行转义，让代码观感好点
val str = """
	|{"key":"value"}
	|{"key1":"value1"}
	""".trimMargin()
```

#### 位运算

```kotlin
shl(bits)		//有符号左移
shr(bits)		//有符号右移
ushr(bits)		//无符号右移
and(bits)		//位与
or(bits)		//位或
inv()			//位非
xor(bits)		//位异或
//使用
val bool1 = true
val bool2 = false
val getbool = bool1.and(bool2)	//and返回false，因为与操作需要都为true
val getbool = bool1.or(bool2)   //or返回true，因为或操作只需要其中一个为true就可以了
//移位操作
val getNum = 8.ushr(2)			//结果为2,原因是8的二进制码为0000 1000，右移两位则变为0000，0010，这个二进制码为2
```

#### 数据容器

```kotlin
//数组，初始化需要指令大小，且不可动态调整
val array = arrayOf(1,2,3)
val array : Array<Any> = arrayOf(1,2,"hello",true)	//数组中的元素可以是任意类型,any相当于java中的Object
val array = arrayOfNulls<String>(5)		//创建一个指定大小且所有元素都为空的数组
array[0] = "下标0的元素内容"
array[1] = "下标1的元素内容"
array[2] = null			//也可以为空
//for循环遍历
for(item in array){
     println(item);
}
array.forEach{
    println(it)
} 
array.forEachIndexed{index,item->println($index : $item)}
//集合
```

```kotlin
//range表达式
val age= 5;
if(age in 0..3){
	println("婴儿")
}else if(){
	println("少年")
}else{
   	println("unknow")
}
//或者
if (age !in 1..3){
}

//when表达式
val shcool  = "小学"
val level : Any when(school){
    "学前班" -> "幼儿"
    "小学" -> "少儿"
    else -> {
        println("unknow")
    }
}
//打印出来的数据为少儿，根据when后括号内的变量来判断
```

### kotlin的NULL空值相关

```kotlin
//在kotlin中，除非特殊声明，否则变量不可为空值
var str:String? = "张三"	//在数据类型后加一个?问号就允许变量为空
str = null 
//安全调用操作符
str?.capitalize()	//?.就是安全调用操作符，当值为空时直接跳过函数调用，而不是返回null
//非空断言操作符
str!!.capitalize()	//!!.也称感叹号操作符，当变量为null时抛出kotlinnull异常
//if判断null
if(str != null){
    str = str.capitalize()
}else{
    println(str)
}
//相比而言安全调用操作符更加灵活，代码更加简洁，而且安全调用操作符可以进行多个函数的链式调用
str = str?.capitalize()?.plus("is great")
//空合并操作符
println(str ?: "张三")	//类似三目运算符，如果str为空则输出张三，如果不为空则输出str的内容
//自定义异常
fun main(){
    var num: Int? = null
    try{
        checkFunction(num)
        num!!.plus(1)
    }catch(e: Exception){
        println(e)
    }
}
fun checkFunction(num: Int?){
    num ?: throw isNumNull()
}
//自定义异常
class isNumNull() : IllegalArgumentException("参数为空")
//先决条件函数，kotlin有内置函数可以抛出自定义的异常信息
checkNotNull()		//如果参数为空，抛出IllegalStateException异常，否则返回非null值
require()			//如果参数为false，则抛出IllegalArgumentException异常
requireNotNull()	//如果参数为Null，则抛出IllegalStateException异常，否则返回非null值
error()				//如果参数为null，则抛出IllegalStateException异常并输出错误信息，否则返回非null值
assert()			//如果参数为false，抛出AssertError异常，并打上断言编译器标记
//Example:	checkNotNull(num,{"参数为空"})
```

#### 与java中有差异的字符串操作函数：

```kotlin
//substring
const val NAME = "it's name"
fun main(){
    val index = NAME.indexOf('\'')
//  val str = NAME.substring(0,index)	//可以这样写，也可以用下方的写法
     var str = NAME.substring(0 until index)
}
//split返回list列表，list支持解构语法特性，允许在一个表达式里给多个变量赋值
const val NAME = "one,two,three"
val data = NAME.split(",")					//返回列表给data
val (first,second,third) = NAME.split(",")	//给多个变量赋值
//replace，字符串替换
val str = "replace string test"
val str2 = str.replace(Regex("[aeiou]")){
    when(it.value){
        "a" -> "A"
        "e" -> "E"
        "i" -> "I"
        "o" -> "O"
        "u" -> "U"
        else -> it.value
    }
}
//字符串比较。在kotlin中用两个==检查字符是否匹配，用三个===检查两个变量是否指向同一个堆的对象，java中用==比较堆地址，equals比较内容
val str = "Json"		//val是只读
val str2 = "Json"
str == str2 	//true,比较内容
str === str2 	//true,因为jvm有一个字符串常量池，两个只读的变量指向同一个字符串，为了节省就指向了同一个地址
//foreach	字符串遍历
"test".foreach{
    println("$it")
}
```

#### 数字类型：

```kotlin
//kotlin提供了安全转换函数
//val number: Int = "8.12".toInt()	抛出异常显示无法转换数据类型
val number: Int? = "8.12".toIntOrNull()	//如果转换失败则返回null
//double转Int
8.2231.toInt()	//会损失精度
8.2231.roundToInt()	//会四舍五入
val str = "%2.f".format(8.2231)	//输出8.22，因为取小数点后两位，且会四舍五入 
```

#### 标准库函数：

```kotlin
//apply，可以看作配置函数，传入一个接收值，然后调用一系列函数来配置使用
fun main(){
    val file = File("C://test.txt").apply{
        setReadable(true)		//可读
        setWritable(true)		//可写
        setExecutable(false)	//不可执行
    }
}
//let，它能让某个变量用it在lambda表达式里引用它，let会把接收者传给lambda，apply不传。函数执行完，apply会返回当前接收者，ley会返回lambda最后一行
val result = listOf(3,2,1).first.let{	//first就是第一个，也就是3
    it * it 		//3*3=9，返回9
}
//使用let和空合并操作符来替代if...else
fun getStr(getName: String?): String{
    return getName?.let{
        "Welcome, $it"
    } ?: "what` your name"
}	//getStr(null)输出what`s your name,	getStr("张三")输出welcome, 张三
//run,光看作用域和apply差不多，但run不返回接收者，run返回的是lambda的结果,返回最后一行
fun main(){
    var file = File("C://test.txt")
    val result = file.run{
        readText().contains("great")	//readText是读取文件，超过2GB就不读取了
    }
}
//run函数也可以用来执行函数引用
"this is a test String".run(::isLong)
fun isLong(str: String) = name.length >= 10 
fun showMessage(isLong: Boolean):String{
    return if(isLong){
        "successa"
    }else{
        "failed"
    }
}
"this is the test String"
	.run(::isLong)
	.run(::showMessage)
	.run(::println) 
//with,他是run的变体，功能是一样的，但调用方式不同，with调用时需要值参作为第一个参数传入
val str = with("this is the test String"){
    length >= 10
}
//also,它和let相似把接收者传参给lambda，但是also返回接收者，let返回lambda结果。also适合针对同一原始对象
var fileContent:List<String>
val file = File("C://test.txt")
	.also{
        println(it.name)
    }.also{
        fileContent = it.readLines()
    }
//takeif,takeif需要判断lambda中提供的条件表达式，给出true或false，如为true返回接收者对象，如为false返回null。
fun main(){
    val result = File("C:\\test.txt")
    	.takeIf{it.exists() && it.canRead()}//如果文件存在并且可读，那么返回File
    	?.readText()
}
//takeUnless，与takeIf相反，只有false才返回接收者对象，true返回null
fun main(){
    val result = File("C:\\test.txt")
    	.takeUnless{it.isHidden }//负负得正，如果文件可见那么takeUnless返回false也就是接收者对象
    	?.readText()
}
```

#### 内联函数

```kotlin
inline fun <T> myInlineFunction(block: () -> T): T {
    println("Before calling block")
    val result = block()	//被调用时执行的内容
    println("After calling block")
    return result
}
//使用内联函数
fun main() {
    val result = myInlineFunction {
        println("This is the block of code")	//调用函数后作为参数block所执行的内容
        42
    }
    println("Result: $result")
}
/*	实际输出
before calling block
This is the block of code	这一行就是在调用内联函数时函数内作为参数的block所打印的内容
After calling block
Result: 42
*/
```





#### 集合：list允许可重复元素，set不允许可重复元素。也就是list是有序可重复，set是无序不重复

```kotlin
//list、set、map都一样分为可变变量和只读变量，也就是var和val

//list创建与元素获取。getOrElse是一个安全索引取值函数，第一个参数是索引值，第二个参数是提供默认值的lambda表达式。如果索引值不存在可以用来代替异常 。getOrNull也是一个安全索引取值函数，返回null结果而不是抛出异常
fun main(){
    val list = listOf("lsit1","list2")
    val str = list[0]	//如果索引越界会抛出异常
    list.getOrElse(2){"Unknown"}	//因为索引越界所以返回Unknown
    list.getOrNull(2) ?: "Unknown"	//没有第三个元素所以返回null
}
//可变列表，可以使用mutableListOf函数。List支持使用toList和toMutableList函数动态实现只读列表和可变列表的相互转换
fun main(){
    val list = mutableListOf("lsit1","list2")
    list.add("list3")
    list.remove("list3")
    listOf("lsit1","list2").toMutableList()	//转换成mutablelis
    list.toList()	//转换成list
}
//mutator，基于lambda表达式指定的条件删除元素
fun main(){
    val list = mutableListOf("lsit1","list2")
    list += "list3" 
    list -= "list3"
    list.removeOf{ it.contains("list1")}	//如果存在list1，那么删除它，contains是如果字符串有list1字符的都删除
}
//list遍历,for in 遍历、
fun main(){
    val list = listOf("lsit1","list2")
    for (s in list){
        //todo
    }
    list.forEach{
        //todo
    }
    list.forEachIndexed{ index,item ->
        //todo
    }
}
//结构语法过滤元素，通过_符号过滤元素
fun main(){
    val list = listOf("lsit1","list2")
    val (origin,_) = list		//这样赋值只有list1，list2过滤掉了
}
```

```kotlin
//set创建与元素获取，通过setOf创建set，使用elementAt获取元素
fun main(){
    val set = setOf("list1","list2")
    set.elementAt(1)
}
//可变集合，通过mutableSetOf创建可变的set集合
fun main(){
    val set = mutableSetOf("list1","list2")
    set.add("list3")	//或者set += "list3",与list同理
}
//集合转换，常用可以把list转为set，去掉重复的元素
listOf("list1","list2","list1").toSet()	//去除重复元素
listOf("list1","list2","list1").distinct()	//也可以去重后转换为list输出
//数组类型，虽然kotlin也有各种数组，虽然是引用类型，但是可以编译为java基本数据类型
listOf(10,20).toIntArray() //list转换成int数组
```

```kotlin
//map集合
fun main(){
    mapOf("key" to "value","key1" to "value1")	//to看上去像是关键字，其实是个函数，将前后的键值对转换为pair
    mapOf(Pair("key1","value1"))	//两种方法都可用创建map
}
//map读取
map["key"]			//[]取值运算符，不存在返回null。
map.getValue(jack)	//getValue，不存在抛出异常。
map.getOrElse("key"){"Unknown"}	//getOrElse，不存在可以使用匿名函数返回默认值。
map.getOrDefault("key",0)		//getOrDefault，不存在则返回默认值
//map遍历
map.forEach{
    println("${it.key}, ${it.value}")   
}
map.forEach{ key:String, value:String ->
    println("${it.key}, ${it.value}")
}
//可变map集合。mutableMapOf创建。getOrPut函数是如果键值不存在则添加并返回结果，否则返回存在的键值对
val map = mutableMapOf("key" to "value","key1" to "value1")
map += "key2" to "value3"
map.put("key","value")	//map["key"]="value"
map.getOrPut("key"){"value"}	//如果map不存在key，则添加key，value
```

#### 定义类：

 ```kotlin
 //field用来存储属性数据。如果需要重载get和set的时候才使用field
 class Example(){
     var name = "张三"
     get() = field.capitalize()	//调用获取到的内容的首字母大写
     set(value){
         field = value.trim() 	//调用set后会将内容开头结尾的空格去除
     }
 } 
 fun main(){
     var example = Example()
     example.name = "李四"		//默认调用setName设置为李四
 } 
 //计算属性,通过一个覆盖的get或set运算符来定义，这是field就不需要了
 get() = (1...6).shuffled().first()
 //防范静态条件，如果一个类属性可空又可变，那么引用它之前需要保证它非空，可以用also函数
 class Example(){
     var words:String? = "hello"
     
     fun function(){
         words?.also{
             //TODO
         }
     }
 }
 //主构造函数。在kotlin中，临时变量的命名通常会以下划线开头
 class Example(
     _name:String,
     _age:Int
 ){
     var name = _name
         get() = field.capitalize()	//调用获取到的内容的首字母大写
         private set(value){		//带上private就变成了set不可用，只能可读
             field = value.trim() 	//调用set后会将内容开头结尾的空格去除
         }	
     var age = _age
 }
 fun main(){
     val example = Example("张三",11)																	
 }
 //或者
 class Example(
     _name:String,
     var age:Int
 ){
     var name = _name
         get() = field.capitalize()	//调用获取到的内容的首字母大写
         private set(value){		//带上private就变成了set不可用，只能可读
             field = value.trim() 	//调用set后会将内容开头结尾的空格去除
         }	
 }
 // 次构造函数，可以定义多个构造函数来配置不同的参数组合，也可以初始化代码逻辑
 class Example(
     _name:String,
 	var age:Int
 ){
     var name = _name
         get() = field.capitalize()	//调用获取到的内容的首字母大写
         private set(value){		//带上private就变成了set不可用，只能可读
             field = value.trim() 	//调用set后会将内容开头结尾的空格去除
         }
      constructor(name:String) : this(name,age = 10,inNormal = false)
     //或者添加代码逻辑
      constructor(name:String) : this(name,age = 10,inNormal = false){
          this.name = name.toUpperCase()
      }
 }
 fun main(){
     val example = Example("张三")
 }
 //默认参数。如过构建构造函数时用户没有提供值参，那么使用默认值
 _name:String = "张三"
 _age:Int
 val example = Example(_age = 20)	//如果不赋值必须加上参数名
 //初始化块，会在构造类实例时执行，而java是在类加载时执行的
 init{
     require(age > 0){ "age must be positive"}
 	require(name.isNotBlank){ "name can`t be blank"}
 }
 //初始化顺序 主构造函数声明属性 -> 类级别的属性赋值 -> init初始化块里的属性赋值和函数调用 -> 次构造函数里的属性赋值和函数调用
 //初始化延迟，可以使用lateinit关键字，在用它之前负责初始化
 class Example{
 	lateinit var name:String 
     fun setName(){
         name = "张三"
     }
     fun getName(){
         if(::name.isInitialized)	//安全检查，如果初始化了那么打印名字，如果没有那么无输出
         	println(name)
     }
 }
 fun main(){
 	val example = Example()
 	example.getName()
 }
 //惰性初始化，可以在使用到时才初始化变量
 class Example(_name:String){
     var name = _name
     val config by lazy{}
     private fun loadConfig():String{
         println("loading...")
         return "xxx"
     }
 }
 fun main(){
     val example = Example("张三")
     println(p.config)
 }
 ```

#### 继承：

```kotlin
//在kotlin中，类默认都是封闭的，如果需要继承，那么必须使用open关键字修饰
open class Extend(val name:String){
    fun description() = "Extend: $name"
    open fun load() = "Nothing..."
}
//函数重载，使用override
class ExtendTest : Extend("张三"){
    override fun load() = "ExtendTest loading..."//在kotlin中，如果想要重载方法需要方法携带open并且带上override关键字
    fun special() = "special function"
}
fun main(){
    val extend:Extend = ExtendTest()
    println(extend.load )	//输出loading。继承了父类的对象等于子类，相当于子类 
}
//类型检测
println(extend is Extend)
println(extend is ExtendTest)		//输出为true，true
//如果父类对象想调用子类方法，可以使用as进行转化
if(extend is ExtendTest){
    println((extend as ExtendTest).special())
    //智能类型转换,在同一作用域下，转换一次后就可以直接使用extend.special()了，不用使用as转换
}
//kotlin层次，在kotlin中，每一个类都继承一个共同的父类Any,Java则是继承了Object

```

## 对象：Object关键字,可以定义一个单例。使用Object有三种方式，对象声明，对象表达式，伴生对象

+ 对象声明
```kotlin
object Config{
    init{
        println("config loading...")
    }
    fun doSomething(){
        println("do Something...")
    }
}
fun main(){
    Config.doSomething()	//kotlin中，使用单例直接使用类名就可以了
} 
```

+ 对象表达式：如果类只使用一次，那么可以使用object将某个现有类的变体实例,但是只此一个实例对象
```kotlin
object Config{
    open fun load() = "loading..."
}
fun main(){
    val config = object : Config(){
        override fun load() = "匿名内部类..."
    }
    //config对象只有这一个，需要的话只能重新再实例化一次
    println(config.load())
}
```

+ 伴生对象：使用companion，如果需要将对象的初始化和某个实例类捆绑在一起，可以考虑使用伴生对象，一个类只有一个伴生对象
```kotlin
open class Config{			//相当于静态方法和静态属性。kotlin中没有static关键字
    companion object{		//如果不调用object里的方法或者实例化Config，object才会被实例化，这样更节省内存
        private const val PATH = "C:\\test.txt"
        fun load() = File(PATH).readBytes()
    }
}
fun main(){
    Config.load()
}
```

## 嵌套类：一个类嵌套在另一个类中,如果一个类只对另外一个类有作用，那么嵌套类是合乎逻辑的。

```kotlin
class Example{
    class Example1(var name:String){
        fun show() = println("Example1：$name")
    }
    fun function(){
        
    }
}
fun main(){
    Example.Example1("张三").show()
}
```

## 数据类：使用data关键字声明,数据类提供了toString的个性化实现，常用于保存JSON数据

```kotlin
data class DateClass(var data:Int){
    val isData = data > 0
}
//在数据类中创建Copy函数，在使用数据类时可用使用该函数，同时也可用在使用该函数时修改复制的值
fun copy(data: Int) = dataClass(data)	

data class Pair<out A, out B>(val first: A, val Second: B){	//
    override fun toString(): String = "($first,$Second)"    //重载toString函数，默认无参数则输出参数A和B
}
//Kotlin允许在不使用括号和点号的情况下调用函数，那么这种函数被称为 infix函数。
public infix fun <A, B> A.to(that: B): Pair<A, B> = Pair(this, that)
public fun <T> Pair<T, T>.toList(): List<T> = listOf(first, second)	//转换
```

```kotlin
fun main(){
    println(DateClass(1))
    //如果不使用data关键字，那么输出的是dataClass@xxxx
    //加上了data关键字输出为dataClass(data = 1)
}
//copy函数，用来复制一个对象。除了赋的值不一样，其他的都是一样的。copy不会使用次构造函数，如果需要更改需要手动赋值 
val dataClass = DateClass(1)
val copy = dataClass.copy(2)	
//解构声明，如果定义一个数据类，他会自动为所有定义在主构造函数的属性添加相应的组件函数
class Example(val str:String){
    operator fun component1() = str		//必须命名component1，不能为component0
}
fun main(){
    val (x) = Example("张三")
    println("$x")
}
//运算符重载
data class Example(var x:Int,var y:Int){
    operator fun plus(other:Example) = Example(x + other.x, y + other.y)
}
/*
常见操作符的函数名	+：plus	+=：plusAssign 	==：equals	>：compareTo	[]：get		..：RangeTo	in：contains
				添加对象	添加并赋值给前面	同Java		同Java	 返回指定元素		创建range	 包含则返回true
*/
fun main(){
    val example = Example(1,2)
    val example2 = Example(1,2)
    println(example + example2)	//输出(2,4)
}
//枚举类,常用来定义常量集合的特殊类
enum class Mum{
    ONE,
    TWO,
    THREE,
    FOUR
}
fun main(){
    println(Num.ONE)
}
//枚举类也可以定义函数
enum class Num(private val example:Example ){
    ONE(Extend(1)),
    TWO(Extend(2)),
    THREE(Extend(3)),
    FOUR(Extend(4));	//如果要写函数那么枚举结尾需要加分号
    
    fun update(exampleTest:Example) = Example(exampleTest.x + example.x)
}
fun main(){
    println(Num.ONE.update(Example(1)))	//输出2
}
//代数数据类型以及密封类，密封类可以有多个子类，如果要继承密封类，子类必须和他定义在同一个文件里
//enum class Num{		
//    ONE,
//    TWO,
//    THREE,
//   FOUR;
//}
//class getNum(var num:Num){	//代数数据类型
//    fun checkNum():String{
//        return when(num){
//            Num.ONE -> "1"
//            Num.TWO -> "2"
//            Num.THREE -> "3"
//            Num.FOUR -> "4"
//        }
//    }
//}
sealed class Num{		//密封类的属性需要继承密封类
    object num1 : Num()
    object num2 : Num()
    class Qualified(val num:Int) : Num()
}
class getNum(var num:Num){	//密封类
    fun checkNum():Int{
        return when(num){
            is Num.num1 -> 1
            is Num.num2 -> 2
            is Num.Qualified -> (this.num as Num.Qualified).num
        }
    }
}
fun main(){
//    val num = Num(Num.TWO).checkNum()
    //val num = Num.num1
    val num = Num.Qualifed(123) 
    val isNum1 = getNum(num)
    println(isNum1.checkNum())
}
```

## 接口定义：

```kotlin
//kotlin所有的接口属性和函数实现都要使用override关键字，接口中定义的函数不需要open，默认就是open
interface Movable{
    var SpeedMax:Int
    var wheels:Int
    
    fun move(movable:Movable):String
}
class car(_name:String,override var wheels:Int = 4):Movable{
    override var SpeedMax:Int
    			get() = TODO("not implemented")
    			set(value){}
    override fun move(movable:Movable):String{
        TODO("not implemented")
    }
}

fun main(){
    
}
//可以在接口里默认提供属性的getter方法和函数实现
interface Movable{
    var SpeedMax:Int
    		get() = (1..500).shuffled().last()
    var wheels:Int
    
    fun move(movable:Movable):String
}
```

## 抽象类：

```kotlin
//定义抽象类需要加上abstract关键字。与java没什么差别
abstract class gun(val range:Int){
    protected fun doSomething(){
        //TODO
    }
    abstract fun pullTrigger():String
}
class ShotGun(val price:Int):gun(range = 500){
    override fun pullTrigger():String{
        //TODO
    }
}
```

#### 泛型：

```kotlin
class box<T>(item: T){
    private var subject: T = item
}
class man(val name:String, val age:Int)
fun main(){
    val box1 = box(man("张三",20))
}
```

#### 泛型函数：

```kotlin
class box<T>(item: T){
    var available = false
    private var subject: T = item
    fun fetch():T?{
        return subject.takeIf{available}
    }
}
class man(val name:String, val age:Int)
fun main(){
    val box1 = box(man("张三",20))
    box1.available = true
    box1.fetch()?.run(){//TODO}
}
```

#### 多泛型参数：

```kotlin
class box<T>(item: T){
    var available = false
    private var subject: T = item
    fun fetch():T?{
        return subject.takeIf{available}
    }
    //R:return
    fun <R> fetch(subjectModFunction:(T)->R):R?{
        return subjectModFunction(subject).takeIf{available}
    }
}
class man(val name:String, val age:Int)
class boy(val name:String,val age:Int)
fun main(){
    val box1 = box(man("张三",20))
    box1.available = true
    box1.fetch()?.run(){TODO}
    val boy = box1.fetch{
        boy(it.name,it.age.plus(15))
    }
}
```

#### 泛型类型约束：

```kotlin
class box<T:Human>(item: T){
    private var subject: T = item
}
class human(val name:String,val age:Int)
class man(val name:String, val age:Int)
fun main(){
    val box1 = box(man("张三",20))	//box限制了类型，只能使用继承了human的类
}
```

#### out协变、in逆变、invariant不变

```kotlin
//out协变。如果泛型类只将泛型类型作为函数的返回，那么使用out可以称之为生产类，主要用来生产指定的泛型对象	out也可用理解为只能读取值，无法存储值
interface Production<out T>{
    fun product():T
}
//in逆变。如果只将泛型类型作为函数的参数入参，那么可以使用in，称之为消费类/接口，主要用来消费指定的泛型对象	in可用理解为将值进行存储
interface Consumer<in T>{
    fun product(item:T)
}
//invariant不变。//如果泛型类既将泛型类型作为函数参数，又作为函数输出，那么不用out和in
interface ProductionConsumer<T>{
    fun product():T
    fun Consume(item:T)
}
//Example
open class Food	//开放继承的基类
open class FastFood:Food()
class Burger:FastFood()
//out范例
class FoodFactory : Production<Food>{
    override fun product():Food{
        //TODO
        return Food()
    }
}
class FastFoodFactory : Production<FastFood>{
    override fun product():FastFood{
        //TODO
        return FastFood()
    }
}
class BurgerFactory : Production<Burger>{
    override fun product():Burger{
        //TODO
        return Burger()
    }
}
//in范例
class EveryBody: Consumer<Food>{
    override fun consume(item:Food){
        //TODO
    }
}
class ModernPerople : Consumer<FastFood>{
    override fun consumer(item:FastFood){
        //TODO
    }
}
class American : Consumer<Burger>{
    override fun consumer(item:Burger){
        //TODO
    }
}
//使用out产生协变达成泛型声明父类的效果，且可以使用子类
fun main(){
    val production1:Production<Food> = FoodFactory() 
    val production2:Production<Food> = FastFoodFactory()
    val production3:Production<Food> = BurgerFactory()
    //子类泛型对象赋值给父类泛型对象使用out
    val consumer1:Consumer<Burger> = EveryBody()
    val consumer2:Consumer<Burger> = ModernPeople()
    //将Burger修改为Food后报错，因为in只能父类赋值给子类
    val consumer3:Consumer<Burger> = American()
    //父类泛型对象赋值给子类泛型对象使用in
    //在java中也可以做到类似效果，具体为<? extend T>以及 <? super T>
}
```

#### vararg关键字与get函数

```kotlin
//vararg可变参数，与java的...相似。
class box<T>(vararg item: T){
    private var subject:Array<out T> = item
    fun<R> fetch(index:Int, subjectModFunction:(T)->R):R?{
        return subjectModFunction(subject[index]).takeIf{available}
    }
    operator fun get(index:Int):T? = subject[index]?.takeIf{available}	//重载get，使box1[0]不报错
}
class man(val name:String, val age:Int)
fun main(){
    val box1 = box(
        man("张三",20)
        man("李四",21)
    )
    val man = box1.fetch(1){
        man(it.name,it.age.plug(14))
    }
}
//[]操作符取值，可以重载运算符函数get
例如:box1[0]	//需要进行重载才不报错
```

### 协程

- **viewModelScope** 是预定义的 **CoroutineScope**，包含在 **ViewModel** KTX 扩展中。请注意，所有协程都必须在一个作用域内运行。一个 **CoroutineScope**管理一个或多个相关的协程。
- **launch** 是一个函数，用于创建协程并将其函数主体的执行分派给相应的调度程序。
- **Dispatchers.IO** 指示此协程应在为 I/O 操作预留的线程上执行。
- select,channel

```kotlin
GlobalScope.launch(context = Dispatchers.IO){
            //TODO
        }
```

## Kotlin 函数

##### 前置判断

check( xx ) ： 当判断值位非真时抛出一个非法状态异常后结束程序

require( xx ) ：监测值为false时候，执行括号内容并抛出非法参数异常；若为true时候，则直接跳过括号，运行下面代码。

requireNotNull( xx )：  若为null，抛出非法参数异常。若非Null则跳过花括号，直接运行到 end 。

```kotlin
Boolean value = true;

//check Example，
check(value){
    System.out.println("为false则执行该行后退出程序");
}
System.out.println("为false时不执行该行");

//require Example
require(value){
    System.out.println("为false时抛出异常");
}
System.out.println("为true时跳过require后的输出语句直接执行该行");

//requireNotNull Example
requireNotNull(){
    System.out.println("为null时执行该行语句");
}
System.out.println("为true时跳过括号内的句子，执行该行语句");
```



