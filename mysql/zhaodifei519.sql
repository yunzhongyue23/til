--1.选择部门30中的所有员工：
select * from scott.emp where deptno = 30;
 --2.列出所有办事员(CLERK)的姓名，编号和部门编号：
 select ename,empno,deptno from  scott.emp where job='CLERK'
 --3.列出佣金(comm)高于薪金(sal)的员工：
 select * from scott.emp where comm>sal
 --4.找出佣金（comm）高于薪金百分60的员工
  select * from scott.emp where comm>sal*0.6;
 --5.找出部门10中所有经理(MANAGER) 和部门20中所有办事员（CLERK）的详细资料
select * from scott.emp e1 where e1.job='MANAGER' and e1.deptno=10
union all
select * from scott.emp e2 where e2.job='CLERK' and e2.deptno=20


 --6.找出部门10中所有经理，部门20中所有的办事员，既不是经理又不是办事员，但是薪金大于或等于2000的所有员工的资料：
select * from scott.emp e1 where e1.job='MANAGER' and e1.deptno=10
union all
select * from scott.emp e2 where e2.job='CLERK' and e2.deptno=20
union all
select * from scott.emp e3 where e3.job<>'CLERK' and  e3.job='MANAGER' and e3.sal>=2000;
 --7.找出收取佣金（comm）的员工的不同工作：[DISTINCT->消除重复的关键字]
 select distinct job from emp where comm >0;
 --8.找出不收取佣金或者佣金小于100的员工：
 select * from scott.emp where  comm < 100;

 --9.找个各月倒数第三天受雇的所有员工：
--使用LAST_DAY()函数
select * from scott.emp where last_day(hiredate)-2=hiredate

 --10.找出早于12年前受雇的员工：
--注意使用MONTHS_BETWEEN(今天,雇佣日期)
select *  from scott.emp where MONTHS_BETWEEN(sysdate,hiredate) >12*12

 --11.按照首字母大写的方式显示员工姓名
 select INITCAP(ename)  from scott.emp 
--12.显示正好为5个字符的员工的姓名
select * from scott.emp where length(ename) = 5
 --13.显示不带有"R"的员工姓名：
select * from scott.emp where ename not like '%R%'
--14.显示所有员工姓名的前3个字符：
select  substr(ename,0,3) from scott.emp
--15.显示所有员工的姓名，并且用“x” 替换替换所有的 “A”；
select  regexp_replace(ename,'A','x') from scott.emp
--16.显示满十年服务年限的员工的姓名和受雇日期：
select * from scott.emp where MONTHS_BETWEEN (sysdate , hiredate)>12*10;
 --17.显示员工的详细资料，按姓名排序:
select * from scott.emp order by ename;
 --18.显示员工的姓名和受雇日期，并根据其服务年限，把资料最老的员工排在第在前面：
select  ename ,hiredate from scott.emp order by hiredate
 --19.显示所有员工的姓名，工作和薪金，按工作的降序排序，若工作相同则按薪金排序：
 select ename  ,job ,sal from  scott.emp order by job ,sal

--20.显示所有员工的姓名，加入公司的年份和月份，按受雇日期所在的年排序，若年份相同则讲最早月份的员工排在最前面：
--使用TO_CHAR()函数
 select  ename,extract(year   from   hiredate) 年 ,extract(month   from   hiredate) 月
 from scott.emp order by 年,月

 select  ename,to_char(hiredate,'yyyy') 年 ,to_char(hiredate,'mm') 月
 from scott.emp order by 年,月


 
 --21.显示在一个月为30天的情况所有员工的日薪金，并且忽略余数：
--ROUND() 四舍五入
select round(sal/30,0) from scott.emp
 --22.找出在（任何年份）的2月受聘的所有员工：
 select * from scott.emp where to_char(hiredate,'mm') =2
 --23.对于每个员工，显示其加入公司的天数：
select ceil(sysdate - hiredate) from scott.emp;
 --24.显示姓名字段的任何位置包含“A”的所有员工姓名：
select * from scott.emp  where ename like '%A%'
 --25.以年月的方式显示所有员工的服务年限：
--年：求出总共的月/12 -> 产生小数，并不能四舍五入
--月：对12取余 

select months_between(sysdate,hiredate)/12 服务年 , 
mod(months_between(sysdate,hiredate),12 ) 服务月 
from scott.emp ;
-------------复杂查询，子查询，多表关联--------------
--26.列出至少有三个员工的所有部门和部门信息。[!!]
 select * from scott.dept dept1 where dept1.deptno in(
     select emp.deptno from  scott.emp emp,
     scott.dept dept2 where emp.deptno = dept2.deptno
     group by emp.deptno having count(*) >= 3
 )



 --27.列出薪金比“ALLEN”多的所有员工

 select * from scott.emp emp1 where emp1.sal>
 (select sal from scott.emp emp2 where emp2.ename='ALLEN')
 --28.列出所有员工的姓名及其上级的姓名：
--由于KING并没有上级，所以添加一个(+)号表示左连接
select emp1.ename,(case when emp2.ename is null then '+' else emp2.ename end)
from scott.emp emp1 left join 
scott.emp emp2 on emp1.mgr = emp2.empno ;


 --29.列出受雇日期早于直接上级的所有员工的编号，姓名，部门名称
select emp1.ename, emp2.ename 
from scott.emp emp1  join 
scott.emp emp2 on emp1.mgr = emp2.empno and emp1.hiredate > emp2.hiredate  ;

 --30.列出部门名称和这些部门员工的信息，同时列出那些没有员工的部门。·左右关联的问题，即使没有员工也要显示
 select emp1.* ,dept1.dname from scott.emp emp1 left join scott.dept dept1  on  emp1.deptno = dept1.deptno 
 --31.列出“CLERK”的姓名和部门名称，部门人数：
 --找出所有办事员的姓名和部门编号：
select emp1.ename,dept1.dname,  emp1.deptno, x.nums  from scott.emp emp1 
join scott.dept dept1 on emp1.job='CLERK' and emp1.deptno=dept1.deptno 
join 
(select emp2.deptno deno ,count(*) nums from scott.emp emp2 group by emp2.deptno) x
on emp1.deptno=x.deno


SELECT ename,dname,b.cnt FROM scott.dept d,EMP e,
( SELECT deptno,count(empno) cnt FROM scott.emp GROUP BY deptno) 
b WhERE b.deptno=d.deptno AND e.job='CLERK' AND d.deptno=e.deptno;

 
 --32.列出最低薪金大于1500的各种工作以及从事此工作的全部雇员人数
--按工作分组，分组条件是最低工资大于1500
 select distinct emp.job,nt.nums from scott.emp emp join  
(select job,count(*) nums from scott.emp  group by job) nt
on emp.job = nt.job ;



 --33.列出在部门销售部工作的员工姓名，假设不知道销售部的部门编号
--根据DEPT表查询销售部的部门编号(子查询)
select ename from scott.emp where deptno = 
(select deptno from scott.dept where dname='SALES')


 --34.列出薪金高于工资平均薪金的所有员工，所在部门，上级领导，公司的工资等级。

--求出平均工资：
--列出薪金高于平均工资的所有雇员信息
--和部门表关联，查询所在部门的信息(注意KING 是没有上级的 注意右连接)
--求出雇员的工资等级
select newemp.ename,newemp.dname,newemp.mgr,newemp.sal from
(select emp.*,dept.dname from scott.emp emp 
left join 
scott.dept dept on dept.deptno = emp.deptno
and emp.sal >
(select avg(sal) avgsal from scott.emp)) newemp
inner join scott.salgrade sg on newemp.sal<sg.hisal and  newemp.sal>sg.losal

--35.列出和“SCOTT”从事相同工作的所有员工及部门名称：
--SCOTT从事的工作
--做子查询
--以上的结果存在SCOTT，应该去掉
select emp1.*,dept.dname from scott.emp emp1,scott.dept dept
where emp1.deptno = dept.deptno and emp1.job=
(select emp2.job from scott.emp emp2 where emp2.ename='SCOTT')


 --36.列出薪金等于部门30中员工薪金的所有员工的姓名和薪金
--求出部门30中的员工薪金
--子查询
select ename ,sal from scott.emp where sal in
(select sal from scott.emp where deptno =30)



 --37.列出薪金高于在部门30工作的所有员工的薪金的员工姓名和薪金、部门名称
--在之前的程序进行修改使用>ALL ，比最大还大
--再和dept关联，求出部门名称
select distinct emp.ename,emp.sal,dept.dname from scott.emp emp 
join scott.dept dept on  emp.deptno = dept.deptno  
and emp.sal >all(select sal from scott.emp where deptno =30)


 --38.列出每个部门工作的员工数量、平均工资和平均服务期限
--每个部门工作的员工数量：
--求出平均工资和服务年限
select deptno, count(*) 员工数,round(avg(sal),2) 平均工资,
round(avg(months_between(sysdate,hiredate)/12),2) || '年'  平均服务期限
from scott.emp group by deptno


 --39.列出所有员工的姓名、部门和工资

select ename ,deptno,sal from scott.emp;

 --40.列出所有部门的详细信息和部门人数
--列出所有部门的人数
--把上表当成临时表：【由于40部门没有雇员，所以应该使用0表示
】
select dept.*,t.tcount from scott.dept dept 
join
(select deptno,count(*) tcount from scott.emp group by deptno) t
on dept.deptno = t.deptno
 --41、列出各种工作的最低工资以及从事此工作的雇员姓名：
--按工作分组求出最低工资
--子查询
select emp.sal ,emp.ename  from scott.emp  emp
 join
(select deptno,min(sal) tsal from scott.emp  group by deptno ) t
on emp.sal = t.tsal and emp.deptno = t.deptno
 --42、列出各个部门的MANAGER 的最低薪金：
--求出各个部门MANAGER的工资，按照部门分组
select min(sal) from scott.emp group by job having job='MANAGER',

 --43、列出所有员工的年工资，按照年薪从低到高排序：
 select ename ,sal*12 年工资 from scott.emp order by 年工资 
 --44、查询出某个员工的上级主管，并要求这些主管中的薪水超过3000
select emp2.* from scott.emp emp1 ,scott.emp emp2 where emp1.mgr =emp2.empno and emp2.sal>3000
 --45、求出部门名称中带有’S‘字符的部门员工的工资合计，部门人数
 select count(*) 总人数,sum(sal) 总工资 from(
 select  * from scott.emp where ename like '%S%'
 )
--46、给任职日期超过10年的人加薪10%；
update scott.emp set sal =  sal*(1+0.1)
where months_between(sysdate,hiredate)/12>10
