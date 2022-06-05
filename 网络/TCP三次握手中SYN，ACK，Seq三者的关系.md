https://blog.csdn.net/u014507230/article/details/45310847#:~:text=SYN%20(synchronize)%E6%98%AF%E8%AF%B7%E6%B1%82%E5%90%8C%E6%AD%A5,%E4%BB%A5ACK%E7%A1%AE%E8%AE%A4%E3%80%82%20...


位码即TCP标识位,有六种,SYN(synchronous建立连接),ACK(acknowledgement,确认),PSH(push传送),FIN(finish结束),RST(reset重置),URG(urgent紧急),sequence number(顺序号码),Acknowledgement number(确认号码)

第一次连接,a主机发送syn=1,随机产生一个seq num  n1= 123456的数据包到服务器,b主机由syn=1知道a主机要求建立联机
第二次连接,b主机收到联机请求后,发送syn=1,ack=1,n1+1,随机生成ack num n2 =654321的包
第三次连接,a主机收到b主机的请求后确认n1+1是否正确,以及位码ack是否为1,若正确,则发送ack=1,n2+1,主机b收到后确认ack和n2+1的值是否正确,若正确,则成功建立连接.