#  常用的编码方式
ASCII,ISO-8859-1,GB2312,GBK,GB18030,UTF-16,UTF-8
# java中如何编解码
* ISO-8859-1(拉丁语,又称西欧语言)中中文会被转换成3f,也就是问号,值得注意的是,大部分框架都是使用ISO-8859-1作为默认的编码,所以中文环境下常出现乱码问题.
* GBK是GB2313的扩展,兼容gb2312
* 综合编码性能和编码安全来看,UTF-8是最适合的中文编码
## 在javaweb中涉及到的编解码
### js中的编码问题
java后端一定要在调用getParameter之前设置编码
#### 外部引入的js的编码方式
在script标签中设置charset属性为你想要的编码
#### js URL中的编码问题
为啥会有url的编码问题呢,是因为不同的浏览器对url 的解析不一样,不如IE是默认编码,firefox是utf-8编码,不同的js框架之间对js的编码也不同,但是只有掌握三个函数那么对js url编码的处理也就没有问题了.
`escape`函数会将除了ASCII之后的符号转换成Unicode编码,并且给它们加上%,
`encodeURI`是真正的js处理编码函数,除了少数部分字符,会将URL中的字符转换成UTF-8编码.
`encodeURIComponent` 比`encodeURI`转换的还要彻底,通常用于将一个URI作为参数传递给另一个URI
浏览器端的默认编码是UTF-8,而服务端java的编码是GBK,这时为了为了防止乱码,可以使用双层encodeURIComponent(encodeURIComponent(str))

####  为啥中文会变成???
在ISO-8859-1中,遇到不在码值范围内的字符会统一转成3f,也就是问号.





