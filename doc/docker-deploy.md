##docker部署
### Docker Mongo 部署
 windows 下用toolbox部署docker mongo
 启动后mongo端口号默认是27017
 要在虚拟机里配置转发端口到本机 
 >本机端口 : docker容器端口
 
 如果本地有mongodb服务已经启动了 
 这时连接数据库时如果默认端口会连到本机mongodb
 可以停掉本机mongodb 或者将docker的mongodb改下映射端口号
 windows下如果用toolbox 改变的端口号还要在虚拟机里映射下
 
 部署docker时 如果需要用到很多配置和工具
 可以有两种方式 
 1、写启动文件docker-compose.yml
	同时启动多个镜像在一个容器里 并配置相应参数
2、使用Dockerfile创建镜像 创建镜像时下载需要用到的工具并配置 在Dockerfile里执行一些镜像内的指令 比较方便灵活

可以挂载本地文件夹到容器里进行编译

 ####docker 启动 
 
 #####1 单独启动
	docker run --name mongo-test -p 27018:27017 -v /D/Proj/MovieServer:/data/db -d mongo:latest 
	--auth
 #####2 配合mongo-express在docker-compose.yml里配置一起启动
 ```golang
	version: '3.1'

	services:

	  mongo:
		image: mongo:latest
		restart: always
		volumes:
		  - ./data/db:/data/db
		ports:
		  - 38128:27017
		environment:
		  MONGO_INITDB_ROOT_USERNAME: root
		  MONGO_INITDB_ROOT_PASSWORD: 123456

	  mongo-express:
		image: mongo-express
		restart: always
		ports:
		  - 8081:8081
		environment:
		  ME_CONFIG_MONGODB_ADMINUSERNAME: root
		  ME_CONFIG_MONGODB_ADMINPASSWORD: 123456
```
> 映射端口号 本机端口号:容器端口号

> 建议使用第二种
> 第二种配置了 user 和 psw 则开启了认证登录  单独启动时加 --auth 也是开启了登录认证

**开启登录认证则需要在mongodb里增加要登录的用户 否则无法认证**
进入mongo容器
 `docker exec -it mongo-master bash `
 进入mongodb
 `mongo`
 进入admin管理
 `use admin;`
 创建用户
 `db.createUser({user: 'root',pwd: '123456',roles: [{role: 'userAdminAnyDatabase', db: 'admin'}]});`
 验证
 `db.auth("root","123456");`
 windows下toobox 挂载到容器里的文件夹 默认只有C:\Users文件夹
 若要挂载其他目录 需要在虚拟机里设置共享文件夹

 进到容器里可以查看挂载的目录 
 docker exec -it --user root <container id> /bin/bash
 先切换到root  sudo su 

报错 build command-line-arguments: cannot load github.com/ugorji/go/codec: ambiguous import: found github.com/ugorji/go/codec in multiple modules:
        github.com/ugorji/go v1.1.4 (D:\GoProj\pkg\mod\github.com\ugorji\go@v1.1.4\codec)
        github.com/ugorji/go/codec v0.0.0-20190316192920-e2bddce071ad (D:\GoProj\pkg\mod\github.com\ugorji\go\codec@v0.0.0-20190316192920-e2bddce071ad)

go get github.com/ugorji/go@v1.1.7

