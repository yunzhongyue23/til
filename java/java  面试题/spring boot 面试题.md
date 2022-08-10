### Spring Boot 的核心注解是哪个？它主要由哪几个注解组成的？
核心注解是SpringBootApplication
由Configration,EnableAutoConfigration,ComponentScan组成

### Spring Boot 支持那些日志框架

java.util.Logging  ,log4j2,lockback

### Spring 事务的使用
首先要开启事务管理,在主配置类中添加@EnableTransacialManager注解,然后再service层添加@Transacial注解

### Spring Boot有几种读取配置文件的方式
@PropertySource,@Value,@Envirment,@ConfigruationProperty