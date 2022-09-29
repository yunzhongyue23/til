
https://zhuanlan.zhihu.com/p/63001123#:~:text=%E5%8C%B9%E9%85%8D%E6%9C%89%E6%8C%87%E5%AE%9A%E6%B3%A8%E8%A7%A3%E7%9A%84%E6%96%B9%E6%B3%95%EF%BC%88%E6%B3%A8%E8%A7%A3%E4%BD%9C%E7%94%A8%E5%9C%A8%E6%96%B9%E6%B3%95%E4%B8%8A%E9%9D%A2%EF%BC%89
## execution表达式
基本语法格式为：execution（<修饰符模式>？<返回类型模式><方法名模式>（<参数模式>）<异常模式>？）除了返回类型模式，方法名模式和参数模式外，其它项都是可选的。
```java

// 切点
 	@Pointcut("execution(public * cn.hjljy.*.controller..*.*(..))"）
    public void logCut(){
    
    }

// 这是一个切面,切面,切面
    @Around("logCut()")
    public Object validateParam(ProceedingJoinPoint joinPoint) throws Throwable {
        System.out.println("进入切面进行验证");
        Object obj = joinPoint.proceed();
        return obj;
    }
```

| 模式 | 描述 |
 | - | - |
 | public | public 表示public 级别方法。 可以不写，不写就是所有的方法（public,private,protected等级别的方法） |
 | 开头的 * | 表示方法返回值的类型  * 表示全部 |
 | cn.hjljy..controller | 表示具体的包名，中间使用做通配符 |
 | .. | 表示包以及包下面的子包 |
 | * | 表示全部 |
  | .*(..)   |  |表示全部方法  |



## @args 表达式

args主要是用来限制方法的参数的，args有两种表现形式：@args 和args 使用@args需要通过注解，如果方法里面有参数持有这个注解，就可以。 例如：
```java 	@Pointcut("@args(cn.hjljy.mlog.common.annotation.MlogLog)")
    public void logCut(){}
    @Around("logCut()")
    public Object validateParam(ProceedingJoinPoint joinPoint) throws Throwable {
        System.out.println("进入切面进行验证");
        Object obj = joinPoint.proceed();
        return obj;
    }

```

## @annotation 表达式

匹配有指定注解的方法（注解作用在方法上面） 
```java
	@Pointcut("@annotation(cn.hjljy.mlog.common.annotation.MlogLog)")
    public void logCut(){}
    @Around("logCut()")
    public Object validateParam(ProceedingJoinPoint joinPoint) throws Throwable {
        System.out.println("进入切面进行验证");
        Object obj = joinPoint.proceed();
        return obj;
    }
```

