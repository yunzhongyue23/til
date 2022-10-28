BootStrap.java
```java
package server;  
  
import com.sun.jdi.Bootstrap;  
import server.utils.HttpProtocolUtil;  
  
import java.io.IOException;  
import java.io.OutputStream;  
import java.net.ServerSocket;  
import java.net.Socket;  
  
public class BootStrap {  
    //自定义端口号  
    public static final int port = 8080;  
  
    //启动方法  
    private void start() throws IOException {  
//        创建一个服务套接字,绑定一个指定的接口  
        ServerSocket serverSocket = new ServerSocket(port);  
        System.out.println("启动成功，端口号：" + port);  
        while (true) {  
//            监听到一个连接的套接字,并接受到它.  
            Socket accept = serverSocket.accept();  
//            对于这个套接字返回输出流  
            OutputStream outputStream = accept.getOutputStream();  
            String content = "Hello Word !";  
//            拼接要返回的数据,包含http请求头和 具体的内容  
            String retResult = HttpProtocolUtil.getHeader200(content.getBytes().length) + content;  
//            输出流写入要传输的二进制数据  
            outputStream.write(retResult.getBytes());  
  
            outputStream.close();  
        }  
  
    }  
  
    public static void main(String[] args) {  
        BootStrap bootstrap = new BootStrap();  
        try {  
            bootstrap.start();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
    }  
}
```


HttpProtocolUtil.java

```java

package server.utils;  
  
public class HttpProtocolUtil {  
    /**  
     * 获取200响应结果  
     */  
    public static String getHeader200(int size){  
        return "HTTP/1.1 200 OK \n" +  
                "Content-Type: text/html \n" +  
                "Content-Length: " + size + " \n" +  
                "\r\n";  
    }  
  
    /**  
     * 获取404响应结果  
     */  
    public static String getHeader404(){  
        String str404 = "<p1>404 Not Found</p1>";  
        return "HTTP/1.1 404 Not Found \n" +  
                "Content-Type: text/html \n" +  
                "Content-Length: " + str404.length() + " \n" +  
                "\r\n" + str404;  
    }  
}
```