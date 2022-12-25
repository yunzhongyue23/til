 ### this的绑定、优先级

开发中没有this其实也可以有解决方案(例如：that = this,使用变量记录this值)，但是有this后会更加的方便（例如更改变量名），this本身就是一种记录，但是它是在VO中是动态进行绑定的

1.this在不同的环境下，全局指向的都不同

浏览器：window、

node:{} ,因为node内部是先moudule > 加载 > 编译 >放一个函数 >执行这个函数.apply({},) 就是通过applay这个方法将this都绑定到空对象中

2.this的绑定规则

默认绑定

函数单独调用所在的环境，跟函数声明的区域有关，跟调用位置无关（注意和作用域链进行区分，作用域链跟声明位置有关，this绑定在默认绑定时函数声明的区域有关，跟调用位置无关因为是单独执行，没有绑定）

function foo() {
  console.log(this);
}
function foo1() {
  console.log(this);
  foo() //
}
function foo2() {
  console.log(this);
  foo1() //跟调用的位置无关，因为没有绑定只和作用域有关
}
foo2() 

  

隐式绑定

前提条件：对象的内部有一个对这个函数的引用，没有引用，在绑定时便会报错，正是通过这个引用才绑定到这个对象上

object.foo()这样去调用函数内部的方法，此时函数的this值就会绑定到object

但是使用变量 fn = object.foo() 再去调用这个函数 fn()此时就是默认绑定

  function foo() {
            console.log(this);
        }
        //   1.call
        foo.call(123) //将foo的this绑定成number  Number {123}
        // 2.apply
        foo.apply('aaa')//将foo的this绑定成字符串 String {'aaa'}
        // 3.bind 
        let bar = foo.bind('aaa')  //String {'aaa'}
        bar()

-   new关键字绑定  
    通过一个new关键字调用一个函数（构造函数），这个时候this是在调用这个构造函数时创建出来的对象  
    this == 创建出来的这个对象  
    这个绑定过程就是new的绑定

    function Person(name,age){
        this.name = name //一旦使用这个构造函数实例话一个对象，那么这个this就指向这个对象
        this.age = age
       }
       var p1 = new Person('hjl','20')
       var p2 = new Person('hhh','18')
       console.log(p1.name,p1.age);

补充：[1,2,3].forEach()

特殊函数this的绑定：定时器this永远指向window，DOM监听函数绑定this指向DOM

 var arr = [1,2,3,4,5,6]
       arr.forEach((item)=>{
        console.log(this,item); //指向window
       })  
       arr.map((item)=>{
        console.log(this,item); //指向window
       })  

3.this绑定优先级

优先级：new >显示>隐式>默认

特殊绑定：

1.忽略显示绑定：foo.call(null) foo.call(undefined) 绑定给null和undefined，将会自动绑定给window对象

2.间接函数调用

var obj1 = {
            name: 'obj1',
            foo: function () {
                console.log(this);
            }
        }
        var obj2 = {
            name: 'obj2'
        };  //这种形式一定要加分号
        //    给obj2新创建一个方法，让它等于obj1里面的foo方法
        //赋值之后可以进行在本身进行调用 
        // 这种调用方式是独立函数调用 因此是window
        (obj2.bar = obj1.foo)() 

  

4.箭头函数

箭头函数：ES6新增加的一种函数的编写方法，比普通的函数表表达式更加的简洁

箭头函数不会绑定this、argument属性

箭头函数不能作为构造函数去实例化对象，因为没有this（不能和new一起使用否则会报错）

简写1.当形参只有一个的时候（）可以省略2.执行体只有一句的时候{}可以省略，并且会自动将这句执行体当作返回值返回，但是当执行体是一个对象的时候就不可以省略

简写filter，map,reduce

 let arr = [22,15,448,16]
        let newarr = arr.filter(item =>item % 2 == 0).map(item=> item*100).reduce((preitem,item)=>preitem+item)
        console.log(newarr);