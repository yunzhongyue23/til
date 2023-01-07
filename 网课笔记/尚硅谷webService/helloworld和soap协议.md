JAX-WS的含义是 Java API for XML Web Services

  

  

soap协议, Simple Object Access Protocol;

必须的envelope元素,可以把此xml元素标识为一个soap消息

可选的header元素,包含头部信息

必须的body元素,包含所有的调用和响应信息

可选的fault元素,提供有关在处理此消息所发生的错误信息

一次webService的调用不是方法的调用,不是soap消息之间的输入输出

UDDI 通过访问发现和集成.![](https://cdn.nlark.com/yuque/0/2023/png/25651796/1673099169143-83b2c4ed-3dbf-4f3c-87a6-814e71db6d50.png)

definitions :soap协议的根元素

types:使用的数据类型

message:每个消息均由一个或多个部件构成,,可以把他当做一个java中一个函数调用的参数

portType:类似java中的一个函数库

binding:为每个端口定义消息格式和协议细节

XSD(XML Schema Definition)xml模型定义

![](https://cdn.nlark.com/yuque/0/2023/png/25651796/1673105588885-152f9d09-d16d-4787-b5e9-00791bd91f0f.png)![](https://cdn.nlark.com/yuque/0/2023/png/25651796/1673105588777-91e8e2ac-f24f-401d-a2e8-f19ba2595d19.png)![](https://cdn.nlark.com/yuque/0/2023/png/25651796/1673105588800-f7ea1947-64ec-4ff6-9e12-f649b42b9b0b.png)![](https://cdn.nlark.com/yuque/0/2023/png/25651796/1673105588686-4dd67ef6-92a3-41a2-8802-22c14ecb3d5d.png)