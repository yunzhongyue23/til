## 拥有beanFactory之后的生活
之前是自己去衣柜主动去取衣服然后穿上,有了beanFactory之后,就是一个眼神让佣人去衣柜取衣服,给你穿上

BeanFactory的对象注册和依赖绑定方式
### 直接编码方式
通过registerBeanDefinition,DefaultListableBeanFactory,addIndexedArgumentValue等等之类的方法手动把对象添加到容器中

### 外部文件加载
#### properties配置格式的加载,
spring.factory是一个类似的文件
#### xml配置格式的加载

#### 注解格式


