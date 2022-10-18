查看sql语句执行频率
```sql
show global status like 'Com_______'
```

查看慢查询是否开启
```sql
show variable like 'slow_query_log'
```


```cnf
#开启慢查询 
slow_query_log=1 
#慢查询时间 
long_query_time=2
```
查看是否支持profiling
```sql
select  @@have_profiling
```

查看Profiling 状态
```sql
show @@profiling
```
开启profiling
```sql
set profiling =1 
```
查看 sql 语句的执行情况
```sql
show profiles
```


explain 执行计划
```sql
explain SELECT * from  user  where username ='zhangsan'
```


