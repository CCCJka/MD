#### web概念

1、软件架构

+ c/s：客户端/服务器端

+ b/s：浏览器/服务器端

2、资源分类

+ 静态资源
  + 所有用户访问的结果都是一样的。称为静态资源，静态资源可以直接被浏览器解析
  + 如：**html、css、JavaScript、jpg**
+ 动态资源
  + 每个用户访问后得到的结果可能不一样。称为动态资源。动态资源被访问后，需要线转换为静态资源再返回给浏览器，通过浏览器进行解析
  + 如：**servlet/jsp、php、asp...**

3、网络通信三要素

+ IP：电子设备（计算机）在网络中的唯一标识
+ 端口：应用程序在计算机中的唯一标识。0~65536
+ 传输协议：规定了数据传输的规则
  + 基础协议：
    + TCP：安全协议，三次握手，速度相对比较慢
    + UDP：不安全协议，速度快



#### web常见服务器

+ 概念
  + 服务器：安装了服务器软件的计算机
  + 服务器软件：接收用户的请求，处理请求，做出响应
  + web服务器软件：接收用户的请求，处理请求，做出响应
  + 在web服务器软件中，可以部署web项目，让用户通过浏览器来访问这些项目
+ 常见web服务器软件
  + 动态服务器
    + weblogic：oracle公司，大型的JavaEE服务器，支持所有的JavaEE贵方，收费的
    + webSphere：IBM公司，大型的JavaEE服务器，支持所有的JavaEE贵方，收费的
    + JBOSS：JBOS公司，大型的JavaEE服务器，支持所有的JavaEE贵方，收费的
    + Tomcat：Apache基金组织，中小型的JavaEE服务器，仅仅支持少量的JavaEE规范servlet/jsp，开源且免费。
  + 静态服务器
    + nginx：（代理、反向代理等）极高的并发Nginx处理静态文件、索引文件，自动索引的效率非常高，当然除了当作高性能的静态服务器，还有很多强大的功能
+ 

