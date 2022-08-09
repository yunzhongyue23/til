`entity`层的作用:数据模型层,一个entity对应一张表
`dao`层的作用:(data access object )dao层一定是和数据库中某张表一一对应,准确的说是封装了增删改查的方法.
`util`层的作用:一些工具方法的封装
`mapper`层的作用:将数据库中的表数据映射为java 中的对象
`service`层的作用:业务逻辑的封装
`controller`层的作用:接受页面传过来的参数交给service处理.

打个比喻,dao层是小工,负责对食物进行半加工,service是厨师,负责菜品的完成,controller是跑堂,负责将食物交给顾客.