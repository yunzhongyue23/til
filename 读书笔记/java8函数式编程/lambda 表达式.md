很好的理解了类型推断的概念.
1. 泛型
类型推断之前的写法
```java
List<User>  userList = new ArrayList<User>();
```
类型推断之后的写法
```java
List<User>  userList = new ArrayList<>();
```

2.lambda表达式
```java
List<Integer> list= Arrays.asList(1,2,3);
list.stream().forEach(i-> System.out.println(i));
```

lambda 表达式引用是值而不是变量引用