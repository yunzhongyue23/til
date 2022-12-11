## 第一章mysql架构

### 一、mysql的系统架构

  

![](https://cdn.nlark.com/yuque/0/2022/png/25651796/1670769866346-da2933fe-02b6-438d-9404-963454663f9f.png)**（1）MySQL向外提供的交互接口（Connectors）**

Connectors组件，是MySQL向外提供的交互组件，如java,.net,php等语言可以通过该组件来操作SQL语句，实现与SQL的交互。通过客户端/服务器通信协议与MySQL建立连接。MySQL 客户端与服务端的通信方式是 “ 半双工 ”。对于每一个 MySQL 的连接，时刻都有一个线程状态来标识这个连接正在做什么。

**（2）管理服务组件和工具组件(Management Service & Utilities)**

提供MySQL的各项服务组件和管理工具，如备份(Backup)，恢复(Recovery)，安全管理(Security)等功能。

**（3）连接池组件(Connection Pool)**

负责监听客户端向MySQL Server端的各种请求，接收请求，转发请求到目标模块。每个成功连接MySQL Server的客户请求都会被创建或分配一个线程，该线程负责客户端与MySQL Server端的通信，接收客户端发送的命令，传递服务端的结果信息等。

**（4）SQL接口组件(SQL Interface)**

接收用户SQL命令，如DML,DDL和存储过程等，并将最终结果返回给用户。

**（5）查询分析器组件(Parser)**

首先分析SQL命令语法的合法性，并进行抽象语法树解析，如果sql有语法错误，会抛出异常信息。

**（6）优化器组件（Optimizer）**

对SQL命令按照标准流程进行优化分析，mysql会按照它认为的最优方式进行优化，选用成本最小的执行计划。

**（7）缓存主件（Caches & Buffers）**

缓存和缓冲组件，这里边的内容我们后边会详细的讲解。

**（8）MySQL存储引擎**

MySQL属于关系型数据库，而关系型数据库的存储是以表的形式进行的，对于表的创建，数据的存储，检索，更新等都是由MySQL存储引擎完成的。