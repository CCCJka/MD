## 使用SpringBoot需要在类名上注解RestController，而接口名同样需要注解，Example

```java
@RestController		//需要该注解
@RequestMapping("/apiname")	//需要的接口名
public class ClassName(){}
```

## 在SpringBoot中，总共有Get，Post，Put，Delete四种操作方式，需要的注解如下，Example

```java
@RestController		//需要该注解
@RequestMapping("/apiname")	//需要的接口名
public class ClassName(){
    @GetMapping("/getApi")	//spingBoot的getApi注解
    public void getApiTest(){}
    @PostMapping("/postApi") //spingBoot的postApi注解
    public void postApiTest(){}
    @PutMapping("/putApi") //spingBoot的putApi注解
    public void putApiTest(){}
    @DeleteMapping("/deleteApi") //spingBoot的deleteApi注解
    public void deleteApiTest(){}
}
```

## GetMapping

SpingBoot中，get方法在传入的参数中无法为空，但可以设置一个在传入参数为空时的默认值，如下

```java
@GetMapping("/getApi")
public void getApiTest(@RequestParam(defaultValue = "1") int id){
    //参数为空时，默认值为1
}
```

当需要传入的参数作为索引时，需要添加PathVariable注解，Example

```java
@GetMapping("/getApi/{id}")
public void getApiTest(@PathVariable int id){
    //如果传入的参数不添加该注解，则无法根据参数进行索引
}
```

## PostMapping

在PostMan中请求是选择Body中的raw，传入JSON进行请求

```java
@PostMapping("/postApi")
public void postApiTest(@RequestBody PostBody postBody){
    //RequestBody注解在函数中只能存在一个
    //post请求获取到的JSON字符串默认不解析，当使用RequestBody的注解后会解析为该类
}
```

## PutMapping

put与post相像

```java
@PutMapping("/putApi")
public void putApiTest(@RequestBody PutBody putBody){
    //RequestBody注解在函数中只能存在一个
    //post请求获取到的JSON字符串默认不解析，当使用RequestBody的注解后会解析为该类
}
```

## DeleteMapping

delete与get相像，需要传入参数才能进行相应的操作

```java
@DeleteMapping("/deleteApi/{id}")
public void deleteApiTest(@PathVariable int id){
    //TODO
}
```

