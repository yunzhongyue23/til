<a name="maV2z"></a>
## jwt是什么
JSON web Token 的缩写
<a name="yyCJs"></a>
## jwt 有哪几部分组成
三部分
<a name="Gskuw"></a>
### header 存储一些基本信息
<a name="Xatr1"></a>
### payload 存储有效信息
<a name="fQOKe"></a>
### secret 秘钥
<a name="l16Mt"></a>
## 如何在java中使用jwt
导入jjwt 依赖
```xml
<!-- https://mvnrepository.com/artifact/io.jsonwebtoken/jjwt-api -->
<dependency>
  <groupId>io.jsonwebtoken</groupId>
  <artifactId>jjwt</artifactId>
  <version>0.9.0</version>
</dependency>
<dependency>
  <groupId>javax.xml.bind</groupId>
  <artifactId>jaxb-api</artifactId>
  <version>2.4.0-b180830.0359</version>
</dependency>
<dependency>
  <groupId>com.sun.xml.bind</groupId>
  <artifactId>jaxb-impl</artifactId>
  <version>3.0.0-M4</version>
</dependency>
<dependency>
  <groupId>com.sun.xml.bind</groupId>
  <artifactId>jaxb-core</artifactId>
  <version>3.0.0-M4</version>
</dependency>
<dependency>
  <groupId>javax.activation</groupId>
  <artifactId>activation</artifactId>
  <version>1.1.1</version>
</dependency>
```
```java
package com.example.springsecritytest1;

import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Date;

@SpringBootTest
    class SpringSecrityTest1ApplicationTests2 {

        @Test
        void contextLoads() {
            JwtBuilder jwtBuilder = Jwts.builder().setId("666") //设置jwtid,这是jwt的唯一标识符
                .setSubject("testJwt")//设置jwt的主题,可以能全局唯一,也可能局部唯一
                .setIssuedAt(new Date()) //设置签发日期
                .signWith(SignatureAlgorithm.HS256, "itli");//签发,这是算法和秘钥
             String compact = jwtBuilder.compact(); //jwt压缩成字符串
             System.out.println(compact); //结果是:eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI2NjYiLCJzdWIiOiJ0ZXN0Snd0IiwiaWF0IjoxNjYyNzI4NjczfQ.K529VnVzliog6ZIbLNIA2rC5rwA9vU7OIYkQ-ZEhmHo
            	//{""}
                	
        }

    }



```
