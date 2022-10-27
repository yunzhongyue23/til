

![[32b3ce1d4ebd4378b64cef5c0d08b3e7.png]]


用户点击某个请求路径，发起一个 HTTP request 请求，该请求会被提交到 DispatcherServlet（前端控制器）；
由 DispatcherServlet 请求一个或多个 HandlerMapping（处理器映射器），并返回一个执行链（HandlerExecutionChain）。
DispatcherServlet 将执行链返回的 Handler 信息发送给 HandlerAdapter（处理器适配器）；
HandlerAdapter 根据 Handler 信息找到并执行相应的 Handler（常称为 Controller）；
Handler 执行完毕后会返回给 HandlerAdapter 一个 ModelAndView 对象（Spring MVC的底层对象，包括 Model 数据模型和 View 视图信息）；
HandlerAdapter 接收到 ModelAndView 对象后，将其返回给 DispatcherServlet ；
DispatcherServlet 接收到 ModelAndView 对象后，会请求 ViewResolver（视图解析器）对视图进行解析；
ViewResolver 根据 View 信息匹配到相应的视图结果，并返回给 DispatcherServlet；
DispatcherServlet 接收到具体的 View 视图后，进行视图渲染，将 Model 中的模型数据填充到 View 视图中的 request 域，生成最终的 View（视图）；
视图负责将结果显示到浏览器