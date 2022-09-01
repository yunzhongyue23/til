yaml是json的超集,是一种专门用来书写配置文件的语言.
<a name="SBGEb"></a>
## YAML 写法
数据结构可以用类似大纲的缩排方式呈现，结构通过缩进来表示，连续的项目通过减号“-”来表示，map结构里面的key/value对用冒号“:”来分隔.

<a name="ENOt4"></a>
## YAML绑定配置文件的方式
<a name="L9eV4"></a>
### 1.使用@Value绑定属性值

```java
import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Data
@Component
public class User {
    @Value("${user.username}")
    private String username;
    private String password;
}

```
![value.png](https://cdn.nlark.com/yuque/0/2022/png/25651796/1661949329268-f1cf5f81-6261-4e0c-b525-f89001b252e8.png#clientId=u72511016-bc24-4&crop=0&crop=0&crop=1&crop=1&from=ui&id=u6Qq8&margin=%5Bobject%20Object%5D&name=value.png&originHeight=98&originWidth=584&originalType=binary&ratio=1&rotation=0&showTitle=false&size=9524&status=done&style=none&taskId=u5e05ea79-d120-4167-b77e-b9bc60ab8b3&title=)
<a name="DSXtm"></a>
### 2.使用@ConfigurationProperties获取配置值
```java
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Data
@ConfigurationProperties("user")
@Component
public class User {
    private String username;
    private String password;
}

```
![config.png](https://cdn.nlark.com/yuque/0/2022/png/25651796/1661949408963-184fb957-cda7-4d84-832f-95860ad31065.png#clientId=u72511016-bc24-4&crop=0&crop=0&crop=1&crop=1&from=ui&id=u89be4b34&margin=%5Bobject%20Object%5D&name=config.png&originHeight=80&originWidth=559&originalType=binary&ratio=1&rotation=0&showTitle=false&size=10632&status=done&style=none&taskId=u6202d2c8-7293-4cf9-b1eb-14c5710c297&title=)
<a name="b0Ian"></a>
### 对比一下两者的区别
| <br /> | @ConfigurationProperties | @Value |
| --- | --- | --- |
| 功能 | 批量注入属性到java类 | 一个个属性指定注入 |
| 松散语法绑定 | 支持 | 不支持 |
| 复杂数据类型(对象、数组) | 支持 | 不支持 |
| JSR303数据校验 | 支持 | 不支持 |
| SpEL | 不支持 | 支持 |

<a name="Xl59f"></a>
## YAML属性值校验
<a name="pKFbr"></a>
### 属性值校验的原因
我们知道配置文件是人书写,只要是人写的那么就有可能出错误,为了预防错误,所以,要对yaml文件中穿过来的值进行校验
<a name="P6Hhr"></a>
### 参考实例

- @size (min=6, max=20, message="密码长度只能在6-20之间")
- @pattern (regexp="[a-za-z0-9._%+-]+@[a-za-z0-9.-]+\.[a-za-z]{2,4}", message="请输入正确的邮件格式")
- @Length(min = 5, max = 20, message = "用户名长度必须位于5到20之间")
- @Email(message = "请输入正确的邮箱")
- @NotNull(message = "用户名称不能为空")
- @Max(value = 100, message = "年龄不能大于100岁")
- @Min(value= 18 ,message= "必须年满18岁！" )
- @AssertTrue(message = "bln4 must is true")
- @AssertFalse(message = "blnf must is falase")
- @DecimalMax(value="100",message="decim最大值是100")
- @DecimalMin(value="100",message="decim最小值是100")
- @NotNull(message = "身份证不能为空")
- @Pattern(regexp="^(\d{18,18}|\d{15,15}|(\d{17,17}[x|X]))$", message="身份证格式错误")

<a name="d1L2c"></a>
## YAML加载外部配置文件
<a name="ZpY0l"></a>
### 为什么要加载配置文件
在一些古老的jar包里并没有和spring boot 做融合,仍然有自己的配置文件, 如果我们在spring boot项目中使用这些jar包,就必须使用他们的配置文件,那就面临一个问题,我们只有一个全局配置文件**application.**properties和**application.yml,该如何解决这个问题呢,那就需要加载外部配置文件了不是**
<a name="Is6rS"></a>
### 使用@PropertySource加载自定义yml或properties文件
<a name="ozLDB"></a>
#### properties配置文件加载
```java
@PropertySource(value = {"classpath:user.properties"})
public class User {}

```

<a name="CwRHV"></a>
#### yaml配置文件加载
spring 官方文档明确说明不支持使用@PropertySource加载YAML配置文件，但我们可以通过指定一个自己重写的配置文件处理工厂类来解决这个问题
```java
public class MixPropertySourceFactory extends DefaultPropertySourceFactory {
  @Override
  public PropertySource<?> createPropertySource(@Nullable String name,
                                                EncodedResource resource)
                                                throws IOException {
    String sourceName = name != null ? name : resource.getResource().getFilename();

    if (sourceName != null
          &&(sourceName.endsWith(".yml") || sourceName.endsWith(".yaml"))) {
      Properties propertiesFromYaml = loadYml(resource);
      //将YML配置转成Properties之后，再用PropertiesPropertySource绑定
      return new PropertiesPropertySource(sourceName, propertiesFromYaml);
    } else {
      return super.createPropertySource(name, resource);
    }
  }

  //将YML格式的配置转成Properties配置
  private Properties loadYml(EncodedResource resource) throws IOException{
    YamlPropertiesFactoryBean factory = new YamlPropertiesFactoryBean();
    factory.setResources(resource.getResource());
    factory.afterPropertiesSet();
    return factory.getObject();
  }

}
```

- 然后基于上一节的代码，在Family类的上面加上如下注解即可。通过factory属性明确的指定使用我们自定义的MixPropertySourceFactory加载yml配置文件。
```java
@PropertySource(value = {"classpath:family.yml"}, factory = MixPropertySourceFactory.class)
public class Family {
```

<a name="E9d5W"></a>
#### 使用@ImportResource加载Spring的xml配置文件

<a name="PpiXx"></a>
## SpEL表达式绑定配置项
<a name="i9P0d"></a>
### 使用SpEL表达式绑定字符串集合
```properties
#employee.properties
employee.names=james,curry,zimug,姚明
employee.type=教练,球员,经理
employee.age={one:'27', two : '35', three : '34', four: '26'}
```

```java
// Employee.java
@Data
@Configuration
@PropertySource (name = "employeeProperties",
                 value = "classpath:employee.properties",
                 encoding = "utf-8")
    public class Employee {
        
        //使用SpEL读取employee.properties配置文件
        //#{}里面可以写一些简单的表达式
        @Value("#{'${employee.names}'.split(',')}")
        private List<String> employeeNames;
        
}
```
<a name="ENRlJ"></a>
## 不同环境下的多配置
![多环境配置.png](https://cdn.nlark.com/yuque/0/2022/png/25651796/1661952687572-829e46c7-c8f2-4c8c-9c87-2b9078310121.png#clientId=u72511016-bc24-4&crop=0&crop=0&crop=1&crop=1&from=ui&id=u143bf717&margin=%5Bobject%20Object%5D&name=%E5%A4%9A%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE.png&originHeight=209&originWidth=381&originalType=binary&ratio=1&rotation=0&showTitle=false&size=27669&status=done&style=none&taskId=u20ea379f-f0ea-4488-a57d-6bb67dd48fc&title=)<br />全局配置文件:application.yml<br />开发环境配置文件：application-dev.yml<br />测试环境配置文件：application-test.yml<br />生产环境配置文件：application-prod.yml

```shell
java -jar spring-boot-profile.jar --spring.profiles.active=prod
```

<a name="QG0xl"></a>
## 全局配置文件加载优先级
数字越小,优先级越高<br />![Snipaste_2022-08-31_21-38-12.png](https://cdn.nlark.com/yuque/0/2022/png/25651796/1661953110176-8e57e1b3-8ea2-49f3-8bc1-933fa5db27bf.png#clientId=u72511016-bc24-4&crop=0&crop=0&crop=1&crop=1&from=ui&id=u5124275d&margin=%5Bobject%20Object%5D&name=Snipaste_2022-08-31_21-38-12.png&originHeight=881&originWidth=660&originalType=binary&ratio=1&rotation=0&showTitle=false&size=276965&status=done&style=none&taskId=u7fe5eea6-d0b6-48c1-b155-6797ad88258&title=)

<a name="Sm6X6"></a>
## 配置加载优先级
SpringBoot也可以从以下位置加载配置：优先级从高到低；高优先级的配置覆盖低优先级的配置，所有的配置会形成互补配置。

1. 命令行参数
1. 来自java:comp/env的JNDI属性
1. Java系统属性（System.getProperties()）
1. 操作系统环境变量
1. RandomValuePropertySource配置的random.*属性值
1. jar包外部的application-{profile}.properties或application.yml(带spring.profile)配置文件
1. jar包内部的application-{profile}.properties或application.yml(带spring.profile)配置文件
1. jar包外部的application.properties或application.yml(不带spring.profile)配置文件
1. jar包内部的application.properties或application.yml(不带spring.profile)配置文件
1. @Configuration注解类上的@PropertySource
1. 通过SpringApplication.setDefaultProperties指定的默认属性 	






















