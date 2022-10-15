#### 1.聚合函数

聚合函数是平时比较常用的一类函数，这里列举如下：

-   COUNT(col)   统计查询结果的行数
-   MIN(col)   查询指定列的最小值
-   MAX(col)   查询指定列的最大值
-   SUM(col)   求和，返回指定列的总和
-   AVG(col)   求平均值，返回指定列数据的平均值

#### 2.数值型函数

数值型函数主要是对数值型数据进行处理，得到我们想要的结果，常用的几个列举如下，具体使用方法大家可以试试看。

-   ABS(x)   返回x的绝对值
-   BIN(x)   返回x的二进制
-   CEILING(x)   返回大于x的最小整数值
-   EXP(x)   返回值e（自然对数的底）的x次方
-   FLOOR(x)   返回小于x的最大整数值
-   GREATEST(x1,x2,...,xn)   返回集合中最大的值
-   LEAST(x1,x2,...,xn)   返回集合中最小的值
-   LN(x)   返回x的自然对数
-   LOG(x,y)   返回x的以y为底的对数
-   MOD(x,y)   返回x/y的模（余数）
-   PI()   返回pi的值（圆周率）
-   RAND()   返回０到１内的随机值,可以通过提供一个参数(种子)使RAND()随机数生成器生成一个指定的值
-   ROUND(x,y)   返回参数x的四舍五入的有y位小数的值
-   TRUNCATE(x,y)   返回数字x截短为y位小数的结果

  #### 3.字符串函数

字符串函数可以对字符串类型数据进行处理，在程序应用中用处还是比较大的，同样这里列举几个常用的如下：

-   LENGTH(s)   计算字符串长度函数，返回字符串的字节长度
-   CONCAT(s1,s2...,sn)   合并字符串函数，返回结果为连接参数产生的字符串，参数可以是一个或多个
-   INSERT(str,x,y,instr)   将字符串str从第x位置开始，y个字符长的子串替换为字符串instr，返回结果
-   LOWER(str)   将字符串中的字母转换为小写
-   UPPER(str)   将字符串中的字母转换为大写
-   LEFT(str,x)   返回字符串str中最左边的x个字符
-   RIGHT(str,x)   返回字符串str中最右边的x个字符
-   TRIM(str)   删除字符串左右两侧的空格
-   REPLACE   字符串替换函数，返回替换后的新字符串
-   SUBSTRING   截取字符串，返回从指定位置开始的指定长度的字符换
-   REVERSE(str)   返回颠倒字符串str的结果

#### 4.日期和时间函数

-   CURDATE 和 CURRENT_DATE   两个函数作用相同，返回当前系统的日期值
-   CURTIME 和 CURRENT_TIME   两个函数作用相同，返回当前系统的时间值
-   NOW 和 SYSDATE   两个函数作用相同，返回当前系统的日期和时间值
-   UNIX_TIMESTAMP   获取UNIX时间戳函数，返回一个以 UNIX 时间戳为基础的无符号整数
-   FROM_UNIXTIME   将 UNIX 时间戳转换为时间格式，与UNIX_TIMESTAMP互为反函数
-   MONTH   获取指定日期中的月份
-   MONTHNAME   获取指定日期中的月份英文名称
-   DAYNAME   获取指定曰期对应的星期几的英文名称
-   DAYOFWEEK   获取指定日期对应的一周的索引位置值
-   WEEK   获取指定日期是一年中的第几周，返回值的范围是否为 0〜52 或 1〜53
-   DAYOFYEAR   获取指定曰期是一年中的第几天，返回值范围是1~366
-   DAYOFMONTH   获取指定日期是一个月中是第几天，返回值范围是1~31
-   YEAR   获取年份，返回值范围是 1970〜2069
-   TIME_TO_SEC   将时间参数转换为秒数
-   SEC_TO_TIME   将秒数转换为时间，与TIME_TO_SEC 互为反函数
-   DATE_ADD 和 ADDDATE   两个函数功能相同，都是向日期添加指定的时间间隔
-   DATE_SUB 和 SUBDATE   两个函数功能相同，都是向日期减去指定的时间间隔
-   ADDTIME   时间加法运算，在原始时间上添加指定的时间
-   SUBTIME   时间减法运算，在原始时间上减去指定的时间
-   DATEDIFF   获取两个日期之间间隔，返回参数 1 减去参数 2 的值
-   DATE_FORMAT   格式化指定的日期，根据参数返回指定格式的值
-   WEEKDAY   获取指定日期在一周内的对应的工作日索引

  
 
 #### 5.流程控制函数

流程控制类函数可以进行条件操作，用来实现SQL的条件逻辑，允许开发者将一些应用程序业务逻辑转换到数据库后台，列举如下：

-   IF(test,t,f)   如果test是真，返回t；否则返回f
-   IFNULL(arg1,arg2)   如果arg1不是空，返回arg1，否则返回arg2
-   NULLIF(arg1,arg2)   如果arg1=arg2返回NULL；否则返回arg1
-   CASE WHEN[test1] THEN [result1]...ELSE [default] END   如果testN是真，则返回resultN，否则返回default
-   CASE [test] WHEN[val1] THEN [result]...ELSE [default]END   如果test和valN相等，则返回resultN，否则返回default

