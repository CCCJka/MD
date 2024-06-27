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

```java

```

## PutMapping

```java

```

## DeleteMapping

```java
```

