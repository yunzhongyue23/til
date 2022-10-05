



```java
@Override  
public ClientHttpResponse intercept(final HttpRequest request, final byte[] body,  
      final ClientHttpRequestExecution execution) throws IOException {  
      //拿到uri地址,获取主机名
   final URI originalUri = request.getURI();  
   String serviceName = originalUri.getHost();  
   Assert.state(serviceName != null,  
         "Request URI does not contain a valid hostname: " + originalUri);  
    //ribbon负载均衡客户端
   return this.loadBalancer.execute(serviceName,  
         this.requestFactory.createRequest(request, body, execution));  
}
```


```java
public <T> T execute(String serviceId, LoadBalancerRequest<T> request, Object hint)  
      throws IOException {  
      //根据注册的eureka服务名去获取负载均衡器
   ILoadBalancer loadBalancer = getLoadBalancer(serviceId);  
   // 根据负载均衡器去拿到一台服务
   Server server = getServer(loadBalancer, hint);  
   if (server == null) {  
      throw new IllegalStateException("No instances available for " + serviceId);  
   }  
   RibbonServer ribbonServer = new RibbonServer(serviceId, server,  
         isSecure(server, serviceId),  
         serverIntrospector(serviceId).getMetadata(server));  
  
   return execute(serviceId, ribbonServer, request);  
}
```




```java
protected Server getServer(ILoadBalancer loadBalancer, Object hint) {  
   if (loadBalancer == null) {  
      return null;  
   }  
   // Use 'default' on a null hint, or just pass it on?  
   // 使用负载均衡器去选择服务
   return loadBalancer.chooseServer(hint != null ? hint : "default");  
}
```

```java
public Server chooseServer(Object key) {  
    if (counter == null) {  
        counter = createCounter();  
    }  
    counter.increment();  
    if (rule == null) {  
        return null;  
    } else {  
        try {  
        //使用 rule去选择一台服务,常见的规则有轮询,随机访问
            return rule.choose(key);  
        } catch (Exception e) {  
            logger.warn("LoadBalancer [{}]:  Error choosing server for key {}", name, key, e);  
            return null;  
        }  
    }  
}
```

![[Irule.png]]![[ribbon负载均衡流程.png]]