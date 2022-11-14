### 1. DBWn (database writer,数据库写入进程）

将数据缓冲的数据写入数据文件，是负责数据缓冲区管理的一个background process，默认数量1个，最多10个。参数为db_writer_processes

dbwr的作用：

·通过LRU算法管理数据缓冲区，将dirty buffer写入到datafile中，维护数据缓冲区的clean，以使用户进程总能找到足够的空闲缓冲区。

·通过延迟写数据来优化disk I/O读写。

Dbwr writes when：

·no free buffers

·dirty buffer threshold reached

·checkpoint

·tablespace offline

·time out

·drop table/truncate table

###  2. LGWR（log writer，日志写入进程）

将redo log buffer写入redo log file

logr的作用：

·管理日志缓冲区，将数据库的更改写入日志文件，以便维护数据的一致性，并为数据丢失后进行恢复提供依据。

·通过延迟写日志来优化disk I/O读写  
lgwr writes when：

·3s，commit,redo log buffer 1/3，1M满时，都会触发lgwr写  
·beforc dbwn writes

### 3. ARCH（archiver，归档进程）

当数据库运行在archivelog模式下时，将循环使用的redo log file组在被复写覆盖前进行归档备份。

arch的作用：

·管理redo log file，归档保存因循环复写而将被覆盖的log file，为数据丢失后进行恢复提供依据。

Arch works when：

·Redolog file switch

### 4. CKPT （check point,检查点进程）

负责通知dbwn和lgwr将dirty buffer写入disk，以及时消除因dbwn/lgwr延迟写所造成的数据不一致情况，确保内存中的数据块被规律地写入file，并对数据库数据库控制文件和数据文件进行更新同步（修改文件时间头部），以记录下当前的数据库结构和状态。

ckpt的作用：

·及时保证进行延迟写，防止数据库出现不一致情况。

·及时同步各类数据文件，防止各类数据文件出现不一致情况。

Ckpt works when:

·redolog switch

·database shutdown

·alter tablespace begin/end backup

·alter tablespace/datafile readonly

·log_checkpoint_timeout value reached

·log_checkpoint_interval value reached

### 5. SMON (system monitor,系统监控进程)

smon负责对数据库进行恢复操作，若上次数据库为非正常关闭，则下次启动时smon会自动读取重做日志文件，对数据库进行恢复，同时还负责在临时段或临时表空间中回收不再使用的存储空间，并将各个表空间中的空间碎片进行合并。

Smon’s works

·clean up临时空间：真正的临时段不需要clean up，但某些操作，比如create index产生的临时段当create index的session不正常终止时，此时需要smon来清理；

·Recovers transactions active against unavailable files: 这个过程和实例启动时进行的instance crash recovery(自动前滚和回滚)相似，只不过由于实例启动时某些文件无法访问，而实例启动后的某个时间这些文件可以访问时，smon就会对其执行recover；

·Coalesces free space：如使用字典管理表空间，smon负责将连续的空闲extent合并

·Performs instance recovery of a failed node in RAC: 当rac的某个节点失败时，某个剩余的节点会打开失败节点对应的redo log，进行recover;

·Cleans up OBJ$: obj$是个底层的数据字典，包括所有的数据库对象信息，很多时候，某些对象被删除时，由smon进程来clean up 该视图;

·Shrinks rollback segments：如果设置了optimal size参数，smon进程负责执行回滚段的自动收缩

·"Offlines" rollback segments：当用户offline某个回滚段，但此时该回滚断有active trancsaction，这是回滚段的状态其实是pending offline,而smon进程会定期的检查该回滚段的事务是否完成，完成即将其变为offline；

### 6. PMON (process monitor,进程监控进程）

pmon在用户进程出现故障时进行恢复，清除失效的用户进程，负责清理内存区域和释放该进程所使用的资源，同时监控oracle所有background process。

Smon’s works:

·connection在不正常终止时,pmon负责释放资源，rollback未提交的事务；

·监控后台进程，如果某些后台进程不正常终止，则会重启它（比如dispatcher），或者直接终止实例；

### 7. RECO（recovery，恢复进程）

reco用于分布式数据库，维持在分布式环境中的数据的一致性。

reco有个主要工作，就是recover那些两阶段提交的但由于网络或其它原因造成状态为prepared 的挂起事务。

当某些节点反馈yes给事务协调器可以提交时，但事务协调器还未正式发出可以提交的最后指示时，由于网络的原因，这些节点失去了和事务协调节点的联系，此时这些事务就成为了an in-doubt distributed transaction。此时，RECO就负责定期的联系事务协调器，当联系到时，就会提交或者回滚这些事务了。

### 8. LCKn (lock，锁进程）

在具有并行服务器环境下使用，最大可启用10个lckn进程，哟娜与实例间的封锁。

### 9. Dnnn （dispatcher，调度进程）

dnnn存在于MTS体系结构中，负责接受用户进程的请求，将其放入请求队列中，并为之分配一个服务进程。

### 10. server process服务器进程

是用户进程与服务器交互的桥梁，在oracle server与用户之间，处理用户启动用户进程（如sqlplus）后对oracle server的连接请求，用户进程不能直接连接oracle服务器，而必须通过服务器进程进行交互。

Service process的作用：

·分析并执行用户提交的sql语句

·在sga区缓存中搜索用户进程访问的数据，不存在则访问disk并将其复制在缓存中

·将数据返回给用户进程。

服务器进程的分类：

·Dedicated server process （默认）每个用户单独一份PGA

·MultiTreaded server process      多用户共用一份PGA

SQL>select server,count(*) from v$session group by server;查询当前服务器运行模式

### 11. Uer process （用户进程）

由用户创建，通过服务器进程连接数据库，将用户的sql语句传递给服务器进程并接收运行结果反馈给用户