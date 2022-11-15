### oracle的体系

![](https://cdn.nlark.com/yuque/0/2022/png/25651796/1668519318944-41f11997-0e7d-4a4d-95af-47a93ea18147.png)

**PGA（Program Global Area）区**,作用主要有三点主要有三点：第一，保存用户的连接信息，如会话属性、绑定变量等；第二，保存用户权限等重要信息，当用户进程与数据库建立会话时，系统会将这个用户的相关权限查询出来，然后保存在这个会话区内；第三，当发起的指令需要排序的时候，PGA（Program Global Area）正是这个排序区，如果在内存中可以放下排序的尺寸，就在内存PGA区内完成，如果放不下，超出的部分就在临时表空间中完成排序，也就是在磁盘中完成排序。

**实例**是由一个共享内存区**SGA（System Global Area）** 和一系列后台进程组成的，其中SGA主要被划分为共享池（shared pool）、数据缓存区（db cache）和日志缓存区（log buffer）三类。后台进程包括图2-2中所示的**PMON、SMON、LCKn、RECO、CKPT、DBWR、LGWR、ARCH**等系列进程。

**数据库**是由**数据文件、参数文件、日志文件、控制文件、归档日志文件**等一系列文件组成的，其中归档日志最终可能会被转移到新的存储介质中，用于备份恢复使用。

**共享池（Shared Pool）**，共享池是[SGA](https://baike.baidu.com/item/SGA/1317029?fromModule=lemma_inlink)保留的区，用于存储如[SQL](https://baike.baidu.com/item/SQL?fromModule=lemma_inlink)、PL/SQL[存储过程](https://baike.baidu.com/item/%E5%AD%98%E5%82%A8%E8%BF%87%E7%A8%8B/1240317?fromModule=lemma_inlink)及包、[数据字典](https://baike.baidu.com/item/%E6%95%B0%E6%8D%AE%E5%AD%97%E5%85%B8/1270246?fromModule=lemma_inlink)、锁、[字符集](https://baike.baidu.com/item/%E5%AD%97%E7%AC%A6%E9%9B%86/946585?fromModule=lemma_inlink)信息、安全属性等。该区存放有经过[语法分析](https://baike.baidu.com/item/%E8%AF%AD%E6%B3%95%E5%88%86%E6%9E%90?fromModule=lemma_inlink)并且正确的SQL语句，并随时都准备被[执行](https://baike.baidu.com/item/%E6%89%A7%E8%A1%8C?fromModule=lemma_inlink),保留解析过程,方便下次执行

**数据缓存区**，sql语句的查询结果,执行增删改.

**日志缓存区**保存了数据库相关操作的日志，记录了这个动作，然后由 LGWR后台进程将其从日志缓存区这个内存区写进磁盘的日志文件里

  

**BWn (database writer,数据库写入进程）** 将数据缓冲的数据写入数据文件，是负责数据缓冲区管理的一个background process，默认数量1个，最多10个。参数为db_writer_processes

**LGWR（log writer，日志写入进程）**·管理日志缓冲区，将数据库的更改写入日志文件，以便维护数据的一致性，并为数据丢失后进行恢复提供依据。

**ARCH（archiver，归档进程）** 当数据库运行在archivelog模式下时，将循环使用的redo log file组在被复写覆盖前进行归档备份。

**CKPT （check point,检查点进程）** 负责通知dbwn和lgwr将dirty buffer写入disk，以及时消除因dbwn/lgwr延迟写所造成的数据不一致情况，确保内存中的数据块被规律地写入file，并对数据库数据库控制文件和数据文件进行更新同步（修改文件时间头部），以记录下当前的数据库结构和状态。

**SMON (system monitor,系统监控进程)** smon负责对数据库进行恢复操作，若上次数据库为非正常关闭，则下次启动时smon会自动读取重做日志文件，对数据库进行恢复，同时还负责在临时段或临时表空间中回收不再使用的存储空间，并将各个表空间中的空间碎片进行合并。

**PMON (process monitor,进程监控进程 )** pmon在用户进程出现故障时进行恢复，清除失效的用户进程，负责清理内存区域和释放该进程所使用的资源，同时监控oracle所有background process。

**RECO（recovery，恢复进程）** reco用于分布式数据库，维持在分布式环境中的数据的一致性。

**LCKn (lock，锁进程）**在具有并行服务器环境下使用，最大可启用10个lckn进程，

### oracle 的启动流程

数据库的启动可分为三个阶段，分别是nomount、mount和open。

**startup nomount阶段,** Oracle必须读取到数据库的参数文件（pfile或者spfile），如果读不到该参数文件，数据库根本无法nomount成功！如果读到参数文件，将完成一件非常重要的事，就是根据参数文件中的内存分配策略分配相应的内存区域，并启动相应的后台进程，换言之，就是创建实例instance。

**startup mount阶段,** 实例已经创建了，Oracle继续根据参数文件中描述的控制文件的名称及位置，去查找控制文件，一旦查找到立即锁定该控制文件。控制文件里记录了数据库中的数据文件、日志文件、检查点信息等非常重要的信息，所以Oracle成功锁定控制文件，就为后续读取操作这些文件打下了基础，锁定控制文件成功就表示数据库mount成功，为实例和数据库之间桥梁的搭建打下了基础。

**alter database open阶段,** 根据控制文件记录的信息，定位到数据库文件、日志文件等，从而正式打通了实例和数据库之间的桥梁。“总结一下，nomount阶段仅需一个参数文件即可成功，mount阶段要能够正常读取到控制文件才能成功，而open阶段需要保证所有的数据文件与日志文件和控制文件里记录的名称和位置一致，能被锁定访问更新的同时还要保证没有损坏，否则数据库的open阶段就不可能成功。