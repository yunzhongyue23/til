### 1.查看正在运行中的sql

-- 切换数据库
use information_schema;
-- 查看正在执行的SQL语句
show processlist;

-- 或者直接使用SQL语句查询
select * from information_schema.`PROCESSLIST` where info is not null;

### 2、开启日志模式，记录所有SQL语句执行记录

首先查看日志是否开启了记录
-- 查看日志功能设置状态
show variables like 'general_log'; 
-- 打开日志记录功能
set global general_log=on; 
-- 关闭日志记录功能
set global general_log=off; 
 
 
-- 查看当前日志输出类型：table / file ，可根据需要具体设置
show variables like 'log_output';
 
-- 设置日志输出至table
set global log_output='table';
 
-- 日志输出至table模式，查看日志记录
SELECT * from mysql.general_log ORDER BY event_time DESC;
 
-- 设置日志输出至file
set global log_output='file'; 
 
-- 查看日志输出文件的保存路径
show variables like 'general_log_file';
 
-- 修改日志输出文件的保存路径
set global general_log_file='tmp/general.log'; 
 
-- 日志输出至table模式，清空日志记录
truncate table mysql.general_log;
 
-- 日志输出至file模式，查看日志记录
cat /tmp/general.log