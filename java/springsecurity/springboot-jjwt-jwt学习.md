http://jianshu.com/p/29d7eea97339

jwt主要由三部分组成
#### header  头部
```json
   {
    'typ': 'JWT',
    'alg': 'HS256'
   }
```
`声明类型`，这里是jwt  
`声明加密的算法` 通常直接使用 HMAC SHA256


#### payload  载荷

iss: jwt签发者  
sub: 主题  
aud: 接收jwt的一方  
exp: jwt的过期时间，这个过期时间必须要大于签发时间  
nbf: 生效时间  
iat: 签发时间  
jti: jwt的唯一身份标识，主要用来作为一次性token,从而回避重放攻击。

  
#### Signature

---

-   header (base64后的)
-   payload (base64后的)
-   secret  
    这个部分需要base64加密后的header和base64加密后的payload使用.连接组成的字符串，然后通过header中声明的加密方式进行加盐secret组合加密，然后就构成了jwt的第三部分。  



    将这三部分用.连接成一个完整的字符串,构成了最终的jwt

``` sh
```xml
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ
```
  
```

