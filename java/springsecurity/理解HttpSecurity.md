## 什么是HttpSecurity
一个HttpSecurity类似于xml配置文件一个命名空间下的http标签

## 常用配置项
| OpenIdLogin | 用于基于openid的验证 |
| --- | --- |
| heades | 将安全标头添加到响应 |
| **cors** | 配置跨域资源共享（ CORS ） |
| **sessionManagement** | 允许配置会话管理 |
| **rememberMe** | 允许配置“记住我”的验证 |
| **requestCache** | 允许配置请求缓存 |
| **exceptionHandling** | 允许配置错误处理 |
| **securityContext** | 在HttpServletRequests之间的SecurityContextHolder上设置SecurityContext的管理。 当使用WebSecurityConfigurerAdapter时，这将自动应用 |
| **servletApi** | 将HttpServletRequest方法与在其上找到的值集成到SecurityContext中。 当使用WebSecurityConfigurerAdapter时，这将自动应用 |
| **csrf()**

  | 添加 CSRF 支持，使用WebSecurityConfigurerAdapter时，默认启用 |
| **logout** | 添加退出登录支持。当使用WebSecurityConfigurerAdapter时，这将自动应用。默认情况是，访问URL”/ logout”，使HTTP Session无效来清除用户，清除已配置的任何#rememberMe()身份验证，清除SecurityContextHolder，然后重定向到”/login?success” |
| **anonymous** | **anonymous** |
| **formLogin** | 指定支持基于表单的身份验证 |
| **addFilterAt** | 在指定的Filter类的位置添加过滤器 |

