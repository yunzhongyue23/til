```java
package channel;  
  
import java.io.IOException;  
import java.io.RandomAccessFile;  
import java.nio.ByteBuffer;  
import java.nio.channels.FileChannel;  
  
public class FileChannelDemo {  
    public static void main(String[] args) throws IOException {  
        RandomAccessFile aFile = new  
                RandomAccessFile("D:\\data\\niotest\\01.txt", "rw");  
//        返回此文件关联的唯一信道对象  
        FileChannel inChannel = aFile.getChannel();  
//        分配一个数组缓冲区  
        ByteBuffer buf = ByteBuffer.allocate(48);  
//        读取一个字符序列，从给定的信道到数组缓冲区  
        int bytesRead = inChannel.read(buf);  
//        循环读完  
        while (bytesRead != -1) {  
//            bytesRead返回读取的长度  
            System.out.println("读取： " + bytesRead);  
//            反转读写模式，之前是从信道中读取内容写入到数组缓冲区，现在是读  
            buf.flip();  
//            判断当前位置是否还有元素  
            while (buf.hasRemaining()) {  
//                读取缓冲区中的字节  
                System.out.print((char) buf.get());  
            }  
//            清空缓冲区  
            buf.clear();  
//            继续下一次读入  
            bytesRead = inChannel.read(buf);  
        }  
        aFile.close();  
        System.out.println("操作结束");  
    }  
}
```