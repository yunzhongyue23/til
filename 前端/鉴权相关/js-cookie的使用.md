js-cookie是一个简单的,轻量级的处理cookies的js API，用来处理cookie相关的插件

js-cookie的使用方法
一、先下载

```sh
npm install --save js-cookie
```


二、引入
安装好js-cookie插件后，在我们需要处理cookie的地方，简单的通过import引入就可以使用了

```js
import Cookies from 'js-cookie'
```
三、操作
 添加

```js
// 创建一个名称为name，对应值为value的cookie，由于没有设置失效时间，默认失效时间为该网站关闭时
Cookies.set(name, value)

// 创建一个有效时间为7天的cookie
Cookies.set(name, value, { expires: 7 })

// 创建一个带有路径的cookie
Cookies.set(name, value, { path: '' })
```


```js
// 创建一个value为对象的cookie
const obj = { name: 'ryan' }
Cookies.set('user', obj)


// 获取指定名称的cookie
Cookies.get(name) // value

// 获取value为对象的cookie
const obj = { name: 'ryan' }
Cookies.set('user', obj)
JSON.parse(Cookies.get('user'))

// 获取所有cookie
Cookies.get()
```
删除

```js
// 删除指定名称的cookie
Cookies.remove(name) // value

// 删除带有路径的cookie
Cookies.set(name, value, { path: '' })
Cookies.remove(name, { path: '' })
```

