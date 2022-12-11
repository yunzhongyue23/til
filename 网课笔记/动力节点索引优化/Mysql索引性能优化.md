## 1.Explain

使用EXPLAIN关键字可以模拟优化器执行SQL查询语句，从而知道MYSQL是如何处理SQL语句的。可以用来分析查询语句或是表的结构的性能瓶颈。其作用:

1）表的读取顺序

2）哪些索引可以使用

3）数据读取操作的操作类型

4）那些索引被实际使用

5）表之间的引用

6）每张表有多少行被优化器查询

  EXPLAIN关键字使用起来比较简单： explain + SQL语句：

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e2d9f6d5a2a44fabb585cbcc9e2c47aa~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

## 2 Explain重要字段名

### 2.1 id

select查询的序列号，表示查询中执行select子句或操作表的顺序。

id相同时，执行顺序由上至下。

id不同，如果是子查询，id的序号会递增，id值越大优先级越高，则先被执行。

id相同和不同都存在时，id相同的可以理解为一组，从上往下顺序执行，所有组中，id值越大，优先级越高越先执行。

### 2.2 select_type

查询的类型，常见值有：

SIMPLE :简单的 select 查询,查询中不包含子查询或者UNION。

PRIMARY:查询中若包含任何复杂的子部分，最外层查询则被标记为Primary。

DERIVED:在FROM列表中包含的子查询被标记为DERIVED(衍生),MySQL会递归执行这些子查询, 把结果放在临时表里。

SUBQUERY: 在SELECT或WHERE列表中包含了子查询。

### 2.3 table

显示这一行的数据是关于哪张表的。

### 2.4 type

访问类型排序:

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/00cbec04501a447eaf5d4225bc5b6d1f~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

System：表只有一行记录（等于系统表），这是const类型的特列，平时不会出现，这个也可以忽略不计。

Const：表示通过索引一次就找到了,const用于比较primary key或者unique索引。因为只匹配一行数据，所以很快，如将主键置于where列表中，MySQL就能将该查询转换为一个常量。

eq_ref：唯一性索引扫描，对于每个索引键，表中只有一条记录与之匹配。常见于主键或唯一索引扫描。

Ref：非唯一性索引扫描，返回匹配某个单独值的所有行。本质上也是一种索引访问，它返回所有匹配某个单独值的行，然而，它可能会找到多个符合条件的行，所以他应该属于查找和扫描的混合体。

Range：只检索给定范围的行,使用一个索引来选择行。key 列显示使用了哪个索引

一般就是在你的where语句中出现了between、<、>、in等的查询这种范围扫描索引扫描比全表扫描要好，因为它只需要开始于索引的某一点，而结束语另一点，不用扫描全部索引。

Index：Full Index Scan，index与ALL区别为index类型只遍历索引树。这通常比ALL快，因为索引文件通常比数据文件小。也就是说虽然all和Index都是读全表，但index是从索引中读取的，而all是从硬盘中读的。

All：Full Table Scan，将遍历全表以找到匹配的行。

从最好到最差依次是:system>const>eq_ref>ref>range>index>All 。一般来说，最好保证查询能达到range级别，最好能达到ref。

### 2.5 possible_keys

显示可能应用在这张表中的索引，一个或多个。查询涉及到的字段上如果存在索引，则改索引将会被列出来，但不一定会被查询实际使用上。

### 2.6 key

查询中实际使用的索引，如果为NULL，则没有使用索引。

### 2.7 ref

显示索引的哪一列被使用了。哪些列或常量被用于查找索引列上的值。

### 2.8 rows

rows列显示MySQL认为它执行查询时必须检查的行数。一般越少越好。

### 2.9 extra

一些常见的重要的额外信息：

Using filesort：MySQL无法利用索引完成的排序操作称为“文件排序”。

Using temporary：Mysql在对查询结果排序时使用临时表，常见于排序order by和分组查询group by。

Using index：表示索引被用来执行索引键值的查找，避免访问了表的数据行，效率不错。

Using where：表示使用了where过滤。

  

作者：云中月23  
链接：https://juejin.cn/post/7175854823655342136  
来源：稀土掘金  
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。