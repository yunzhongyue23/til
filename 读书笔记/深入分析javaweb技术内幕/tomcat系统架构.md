connector和container的关系就像是婚姻关系,connector 是男孩子,负责和外面对接,container是女孩子负责处理内部事物,service是两人的结婚证书,server是俩人居住的地方

### servlet容器Container
container采用的是典型的责任链模式,由四个子容器组成,它们分别是,Engine,Host,Context和Wrapper,它们不是同级关系,而是父子关系.

Engine,一个servlet模板引擎.

Host,如果想要运行war程序就要有Host,因为想要运行war就要有web.xml文件,因为web.xml是靠Host解析的,所有想要运行war必有Host.

Context,对应servlet的Context,

Wrapper,对应一个servlet实例.
