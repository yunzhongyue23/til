```java
// Request.java

package serverV2;  
  
import java.io.IOException;  
import java.io.InputStream;  
  
  
public class Request {  
    //请求方式GET、POST  
    private String methodType;  
    //请求URL  
    private String url;  
    //输入流  
    private InputStream inputStream;  
  
  
    public Request() {  
    }  
  
    public String getMethodType() {  
        return methodType;  
    }  
  
    public void setMethodType(String methodType) {  
        this.methodType = methodType;  
    }  
  
    public String getUrl() {  
        return url;  
    }  
  
    public void setUrl(String url) {  
        this.url = url;  
    }  
  
    public InputStream getInputStream() {  
        return inputStream;  
    }  
  
    public void setInputStream(InputStream inputStream) {  
        this.inputStream = inputStream;  
    }  
  
    /**  
     * 构造器  
     * 接受输入流并解析输入流,取出请求方法,http请求头和url  
     */    public Request(InputStream inputStream) throws IOException {  
        this.inputStream = inputStream;  
        parseInputParam(inputStream);  
    }  
  
    //解析参数  
    private void parseInputParam(InputStream inputStream) throws IOException {  
        //只提取第一行,  
        int length = 0;  
        while (length == 0){  
//            返回读取该输入流的字节数并返回  
            length = inputStream.available();  
        }  
//        新建二进制缓冲数组,长度就是输入流的长度  
        byte[] bytes = new byte[length];  
  
        inputStream.read(bytes);  
        String inputStr = new String(bytes);  
        //取出请求中的每一行,并把每一行都存到数组里面  
        String[] split = inputStr.split("\\n");  
//       分割请求方法和 协议版本  
        String[] infoArr = split[0].split(" ");  
        this.methodType = infoArr[0];  
        this.url = infoArr[1];  
  
        System.out.println("=====>>method:" + methodType);  
        System.out.println("=====>>url:" + url);  
    }  
}

```

```java
//Response.java
package serverV2;  
  
import lombok.AllArgsConstructor;  
import lombok.Data;  
import lombok.NoArgsConstructor;  
import server.utils.HttpProtocolUtil;  
import serverV2.utils.StaticResourceUtil;  
  
import java.io.File;  
import java.io.FileInputStream;  
import java.io.IOException;  
import java.io.OutputStream;  
  
@Data  
@AllArgsConstructor  
@NoArgsConstructor  
public class Response {  
    private OutputStream outputStream;  
  
    //V2版本只输出静态资源文件  
    public void outputHtml(String path) throws IOException {  
        //获取到文件的绝对路径  
        String absolutePath = StaticResourceUtil.getAbsolutePath(path);  
        File file = new File(absolutePath);  
        if (file.exists() && file.isFile()) {  
  
            //调用工具类输出文件  
            StaticResourceUtil.outputStaticResource(new FileInputStream(file), outputStream);  
        }else{  
            //404 Not Found  
            output(HttpProtocolUtil.getHeader404());  
        }  
    }  
  
    //输出文件  
    private void output(String path) throws IOException {  
        outputStream.write(path.getBytes());  
    }  
}
```

```java

// Bootstrap.java

package serverV2;  
  
import java.io.IOException;  
import java.io.InputStream;  
import java.io.OutputStream;  
import java.net.ServerSocket;  
import java.net.Socket;  
  
public class Bootstrap {  
    private static final int port = 8080;  
  
    public static void main(String[] args) {  
        Bootstrap bootstrap = new Bootstrap();  
        try {  
            bootstrap.start();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
    }  
  
    /**  
     * V2.0版本  
     */  
    private void start() throws IOException {  
        ServerSocket serverSocket = new ServerSocket(port);  
        System.out.println("启动成功");  
  
        while (true){  
            Socket socket = serverSocket.accept();  
            InputStream inputStream = socket.getInputStream();  
            OutputStream outputStream = socket.getOutputStream();  
  
            //获取到输入输出对象  
            Request request = new Request(inputStream);  
            Response response = new Response(outputStream);  
  
            //将结果写到输出流中  
            response.outputHtml(request.getUrl());  
  
            //一定要把socket关闭  
            socket.close();  
        }  
    }  
}
```


```java
//StaticResourceUtil.java
package serverV2.utils;  
  
import server.utils.HttpProtocolUtil;  
  
import java.io.IOException;  
import java.io.InputStream;  
import java.io.OutputStream;  
  
public class StaticResourceUtil {  
  
    /**  
     * 获取到文件的绝对路径并且替换\\为/方便linux识别  
     */  
    public static String getAbsolutePath(String path) {  
        //获取到当前的绝对路径,  
        String absolutePath = StaticResourceUtil.class.getResource("/").getPath();  
//        考虑linux 系统  
        return (absolutePath + path).replaceAll("\\\\", "/");  
    }  
  
    /**  
     * 根据输入流 对文件进行输出  
     *  
     * @param inputStream  输入流  
     * @param outputStream 输出流  
     */  
    public static void outputStaticResource(InputStream inputStream,  
                                            OutputStream outputStream) throws IOException {  
        //缓冲区  
        int buffer = 1024;  
        int actualOutSize = 0;  
  
        //获取需要输出文件流的长度  
        int outputSize = 0;  
        while (outputSize == 0){  
            outputSize = inputStream.available();  
        }  
  
        //输出请求头  
        outputStream.write(HttpProtocolUtil.getHeader200(outputSize).getBytes());  
  
//        新建数组缓冲区  
        byte[] bytes = new byte[buffer];  
        while (actualOutSize < outputSize){  
            //如果最后不够一个缓冲区的话需要获取到最后的数据length  
            if (actualOutSize + buffer > outputSize) {  
                buffer = outputSize - actualOutSize;  
                bytes = new byte[buffer];  
            }  
            //从输入流中读取  
            inputStream.read(bytes);  
            //写出到输出流  
            outputStream.write(bytes);  
            //刷新输出流  
            outputStream.flush();  
            actualOutSize += buffer;  
        }  
    }  
}

```