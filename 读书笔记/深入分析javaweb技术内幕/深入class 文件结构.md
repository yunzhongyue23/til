## JVM指令集简介
### 与类相关的指令
.source Message.java 表示源文件是 Message.java 
.class  Message 表示类明是Message
.super java/lang/Object  表示父类是Object
checkcast 检验类型转换,检验未通过抛出ClassCastException,
getField  获取指定类的实例域,并把它压入栈顶.
getStatic  获取指定类的静态作用域,并把它压入栈顶
instanceOf  检验对象是否是指定类的实例如果是就把1压入栈顶,如果不是就把0压入栈顶
new  创建一个新的对象,并把它的引用压入栈顶

### 与方法相关的JVM指令
invokeinterface  调用接口方法
invokespecial 调用超类构造方法,实例初始化方法,或私有方法
invokestatic 调用静态方法
invokevirtual 调用实例方法

### 属性的定义
| 数据类型             | 表示方式             |                 |
| ---------------- | ---------------- | --------------- |
| text             | text             |                 |
| column-id-gjzaaz | column-id-4tn8lm | table-id-ql1vsp |
| 数组               | [                | row-id-ujvezz   |
| 类                | L                | row-id-s2ejv7   |
| byte             | B                | row-id-va10ky   |
| boolean          | Z                | row-id-yklsh3   |
| char             | C                | row-id-965miq   |
| double           | D                | row-id-5s1idu   |
| float            | F                | row-id-0ws699   |
| int              | I                | row-id-wt90ah   |
| long             | J                | row-id-r8lnit   |
| short            | S                | row-id-tm3sg0   |
| void             | V                | row-id-2nbpwq   |

