运行命令
```sh
nexus /run nexus
```

本地仓库访问私服设置
```xml
<!--配置本地仓库访问私服的权限-->
<servers>
	<server>
		<id>heima-release</id>
		<username>admin</username>
		<password>admin</password>
	</server>
	<server>
		<id>heima-snapshots</id>
		<username>admin</username>
		<password>admin</password>
	</server>
</servers>
<!--配置本地仓库来源-->
<mirrors>
	<mirror>
		<id>nexus-heima</id>
		<mirrorOf>*</mirrorOf>
		<url>http://localhost:8081/repository/maven-public/</url>
	</mirror>
</mirrors>
```

本地文件上传私服配置
```xml
<distributionManagement>
<repository>
	<id>heima-release</id>
	<url>http://localhost:8081/repository/heima-release/</url>
</repository>
<snapshotRepository>
	<id>heima-snapshots</id>
	<url>http://localhost:8081/repository/heima-snapshots/</url>
</snapshotRepository>
</distributionManagement>
```

发布资源到到私服命令
```
mvn deploy
```