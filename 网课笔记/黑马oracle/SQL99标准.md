# SQL的基本组成

1、数据定义语言。SQL DDL提供定义关系模式和视图、删除关系和视图、修改关系模式的命令。  
2、交互式数据操纵语言。SQL DML提供查询、插入、删除和修改的命令。  
3、事务控制。SQL提供定义事务开始和结束的命令。  
4、嵌入式SQL和动态SQL。用于嵌入到某种通用的高级语言中混合编程。其中，SQL负责操纵数据库，  
高级语言负责控制程序流程。  
5、完整性。SQL DDL包括定义数据库中的数据必须满足的完整性约束条件的命令，对于破坏完整性  
约束条件的更新将被禁止。  
6、权限管理。SQL DDL中包括说明对关系和视图的访问权限。  
7、SQL语言中完成核心功能的9个动词：  
（1）数据查询：Select  
（2）数据定义：Create、Drop、Alter  
（3）数据操纵：Insert、Update、Delete  
（4）数据控制：Grant、Revoke

# 表的创建、修改和删除

## 创建

语句格式：CREATE TABLE <表名> (<列名><数据类型>[列级完整性约束条件]  
 [，<列名><数据类型>[列级完整性约束条件]]…   
 [，<表级完整性约束条件>])；   
注：[ ]表示可选，< >表示必填

### 实体完整性约束

主码（主键）

PRIMARY KEY

主码为属性组

PRIMARY KEY(属性名1，属性名2)

### 参照完整性约束

外码（外键），在列后加

References 表名（属性名）

外码（外键），在最后加

Foreign Key(属性名) References 表名（属性名）  
 [ON DELETE[CASCADE|SET NULL]]

ON DELETE CASCADE 表示删除被参照关系的元组时，同时删除参照关系中的元组；  
ON DELETE SET NULL表示删除被参照关系的元组时，将参照关系的相应属性值置为空值。

### 属性上的约束

（1）NULL：表示为空；NOT NULL表示不能为空；  
（2）UNIQUE：表示取值唯一；  
（3）NOT NULL UNIQUE：表示取值唯一且不为空，与属性列后面的PRIMARY KEY可互换；  
（4）CHECK：限制列中值的取值范围。  
如：CHECK (Sex='男' OR Sex='女')，CHECK (余额>=0)，CHECK (年龄>=18 AND 年龄<=60)，  
CHECK (离职日期 > 入职日期)

## 修改

语句格式：ALTER TABLE <表名> [ADD <新列名><数据类型>[列级完整性约束条件]]  
 [DROP <完整性约束名>]  
 [Modify <列名><数据类型>])； 

ALTER TABLE S ADD Zap CHAR(6); //在表S中新增一列ZAP，该列的数据为空  
ALTER TABLE S MODIFY Status INT; //将表S的Status属性的数据类型更改为INT  
ALTER TABLE S ADD Constraint C_cno CHECK(......) //在表S中新增CHECK约束，取名为C_cno

## 删除

语句格式：DROP TABLE <表名>  
如：  
DROP TABLE S； //表删除后，不再是数据库模式的一部分

# 索引的创建和删除

## 1、索引的概念

• 数据库中的索引与书籍中的索引类似，在一本书中，利用索引可以快速查找到所需信息，无须阅  
读整本书。在数据库中，索引使数据库无须对整个表进行扫描，就可以在其中找到所需数据。

• 比如在字典中，我们按字母建立索引。在数据库中，索引是某个表中的一列或者若干列的值的集合，和相应的指向表中物理标识这些值的数据页的逻辑指针清单。

## 2、索引的作用

（1）通过创建唯一索引，可以保证数据记录的唯一性。  
（2）可以大大加快数据检索速度。  
（3）可以加速表与表之间的连接，这一点在实现数据的参照完整性方面有特别的意义。  
（4）在使用ORDER BY和GROUP BY子句中进行检索数据时，可以显著减少查询中分组和排序的时间。  
（5）使用索引可以在检索数据的过程中使用优化隐藏器，提高系统性能。  
索引分为聚集索引和非聚集索引。聚集索引是指索引表索引项的顺序与表中记录的物理顺序一致的索引

## 3、建立索引

语句格式：CREATE [UNIQUE][CLUSTER] INDEX <索引名>  
 ON <表名>(<列名>[<次序>][,<列名>[<次序>]]…);

-   次序：ASC(升序)或DESC（降序)，默认为升序。 
-   UNIQUE：表明此索引的每一个索引值只对应唯一的数据记录。
-   CLUSTER：表明要建立的索引是聚簇索引，索引项的顺序是与表中记录的物理顺序一致的索引组织。

如：  
CREATE UNIQUE INDEX S_Sno on S(Sno); //在表S的Sno列上建立索引S_Sno，默认为升序  
CREATE UNIQUE INDEX P_Pno on P(Pno); //在表P的Pno列上建立索引P_Pno，默认为升序  
CREATE UNIQUE INDEX J_Jno on J(Jno); //在表J的Jno列上建立索引J_Jno，默认为升序  
CREATE UNIQUE INDEX SPJ_NO on SPJ(Sno ASC,Pno DESC,Jno ASC);  
 //在表SPJ上建立索引SPJ_NO，属性Sno按升序，Pno按降序，Jno按升序

## 4、删除索引

语句格式：DROP INDEX <索引名>  
例：DROP INDEX StudentIndex； //删除索引StudentIndex

# 视图的作用和删除

## 创建视图

语句格式：CREATE VIEW 视图名(列表名)  
 AS SELECT 查询子句  
 [WITH CHECK OPTION]; 

视图的创建中，必须遵循如下规定：  
（1）子查询可以是任意复杂的SELECT语句，但通常不允许含有ORDER BY子句和DISTINCT短语。  
（2）WITH CHECK OPTION表示对UPDATE,INSERT,DELETE操作时保证更新、插入或删除的行满足视图  
定义中的谓词条件（即子查询中的条件表达式）  
（3）组成视图的属性列名或者全部省略或者全部指定。如果省略属性列名，则隐含该视图由SELECT  
子查询目标列的主属性组成。

## 删除视图

语句格式：DROP VIEW 视图名  
如：DROP VIEW CS_STUDENT //删除视图CS_STUDENT

# 数据操作

## 运算符

运算符

 

集合成员运算符

IN/NOT IN

字符串匹配运算符

LIKE

空值比较运算符

IS NULL/IS NOT NULL

算数运算符

> >= < <= = <>

逻辑运算符

AND/OR/NOT

## 连接查询

## 子查询

EXISTS/NOT EXISTS

## 聚集函数

AVG()

MIN()

MAX()

SUM()

COUNT()

## 分组查询

GROUP BY

HAVING

## 集合操作

UNION/UNION ALL

INTERSECT

EXCEPT