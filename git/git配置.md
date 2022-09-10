### 配置文件
windows端是 .gitconfig,可以使用everything快速定位文件位置.

### 配置命令
配置用户名和密码
```sh
## 全局配置,在用户的.gitconfig目录下生效
$ git config --global user.name "yunzhongyue"
$ git config --global user.email yunzhongyue@gmail.com
## 局部配置,生效在当前目录下,保存在当前项目的 .git/config中
$ git config --global user.name "yunzhongyue"
$ git config --global user.email yunzhongyue@gmail.com
## 查看已有的配置信息
$ git config --list
```
