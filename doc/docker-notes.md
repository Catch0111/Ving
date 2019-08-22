##docker 命令
###镜像操作
`docker pull ubuntu:18.04`	--获取ubuntu镜像
`docker images` --列出本地所有镜像 
`docker images ls`	--详细信息
`docker images ls ubuntu`	--列出Ubuntu镜像 部分镜像
`docker image ls -a` --中间镜像有列出来
`docker system df`  --列出镜像和容器的占用信息
`docker image ls -f since=mongo:3.2` 列出mongo:3.2之后创建的镜像
`docker image prune`	--删除玄虚镜像
`docker image rm 222` --删除镜像 知道镜像id前三个数就可以
`docker image rm $(docker image ls -q redis)`  -- q以特定格式显示 删除所有redis
镜像
`docker commit \`
    `--author "Tao Wang <twang2218@gmail.com>" \`
    `--message "修改了默认网页" \`
    `webserver \`
    `nginx:v2`	--将当前容器webserver保存为镜像nginx:v2 commit慎用 通常左故障排查备份镜像用
###运行镜像
`$ docker run ubuntu:18.04 /bin/echo 'Hello world'`
`Hello world`
启动后运行完语句直接就退出了
`docker run -it --rm \`
    `ubuntu:18.04 \`
    `bash`
-it : -i:交互操作 -t: 终端
-rm : 退出后删除
bash 命令

`docker run -dit ubuntu:latest` 在后台运行容器 用docker logs xxx 查看日志
进入容器 `docker attach` 命令或 `docker exec` 命令
用attach进入容器后 exit会终止容器运行 用exec配合-it进入后 exit会退出容器 不会终止容器
推荐用exec进入容器
`docker exec -it 69d1 bash`
`docker container ls -a` 列出容器
`docker container rm  trusting_newton` 删除容器
`docker run -p 6379:6379 -v $PWD/data:/data xxx`
alpine的镜像非常小 里面没有bash 所以进入时不能以bash方式进入 可以如下进入
`docker exec -it CONTAINER_ID sh`
scratch 为空白镜像 占用的最小 也可以运行cmd命令 但无法进入 不能通过sh进入和运行命令
运行镜像时 -p 端口映射 -v 文件夹挂载
###定制镜像
FROM [镜像基础] 
	基础镜像 如 ubuntu、debian、centos、fedora、alpine 等 scratch 为空白镜像
	服务类镜像 如 nginx、redis、mongo、mysql、httpd、php、tomcat 等
RUN 
	shell格式
		RUN <命令>  直接像shell命令行一样执行命令
	exec格式
		RUN ["可执行文件", "参数1", "参数2"] 运行可执行文件

	每执行一个RUN命令 会生成一层镜像 每次会累加 产生的镜像就会臃肿
	所以要将所有RUN命令写在同一个语句里 如：
	FROM debian:stretch

	RUN buildDeps='gcc libc6-dev make wget' \
		&& apt-get update \
		&& apt-get install -y $buildDeps \
		&& wget -O redis.tar.gz "http://download.redis.io/releases/redis-5.0.3.tar.gz" \
		&& mkdir -p /usr/src/redis \
		&& tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
		&& make -C /usr/src/redis \
		&& make -C /usr/src/redis install \
		&& rm -rf /var/lib/apt/lists/* \
		&& rm redis.tar.gz \
		&& rm -r /usr/src/redis \
		&& apt-get purge -y --auto-remove $buildDeps 
	构建最后的自动清理很必要
COPY [--chown=<user>:<group>] <源路径>... <目标路径>
	COPY package.json /usr/src/app/
ADD 命令和COPY用法一样 但增加了从url复制到镜像 并且可解压压缩文件 不建议用ADD 尽量用COPY
docker build [选项] <上下文路径/URL/->  --构建镜像
	docker build -t nginx:v3 . [.]为当前目录 会被传进Dockerfile里作为上下文

CMD 用法和 RUN 一样 也是两种 是在启动容器时执行的命令 就是用于指定默认的容器主进程的启动命令的
	shell格式
		RUN <命令>  直接像shell命令行一样执行命令
	exec格式
		RUN ["可执行文件", "参数1", "参数2"] 运行可执行文件
	如ubuntu的默认CMD 是 /bin/bash
	docker run -it ubuntu 就会默认进入bash
	docker run -it ubuntu cat /etc/os-release 是用cat /etc/os-release替换了默认的bash命令
	shell格式 CMD echo $HOME
	exec格式 CMD [ "sh", "-c", "echo $HOME" ]
	Docker 不是虚拟机，容器中的应用都应该以前台执行，而不是像虚拟机、物理机里面那样，用 systemd 去启动后台服务，容器内没有后台服务的概念。
	CMD service nginx start 启动服务是不对的 会被解释为 CMD [ "sh", "-c", "service nginx start"] 启动的主进程就是shell shell执行完就退出了 达不到启动服务的目的
	改为 CMD ["nginx", "-g", "daemon off;"] 不允许后台运行
	获取当前网络ip的例子：
	FROM ubuntu:18.04
	RUN apt-get update \
		&& apt-get install -y curl \
		&& rm -rf /var/lib/apt/lists/*
	CMD [ "curl", "-s", "https://ip.cn" ]

	docker build -t myip .
	$ docker run myip
	当前 IP：61.148.226.66 来自：北京市 联通

	如果cmd是个指令 CMD [ "curl", "-s", "https://ip.cn" ] 则构建完镜像后 run这个镜像会马上退出 输出结果 因为curl进程运行完就结束了 这样这个镜像就类似一个命令了

ENTRYPOINT 用法和RUN一样 也是在指定容器启动程序及参数
	当指定了 ENTRYPOINT 后，CMD 的含义就发生了改变，不再是直接的运行其命令，而是将 CMD 的内容作为参数传给 ENTRYPOINT 指令，换句话说实际执行时，将变为：
	<ENTRYPOINT> "<CMD>"
	应用一：
		docker run myip -i [参数]  后面的参数-i 是替换默认的CMD命令的 是会替换整个CMD命令 
		但现在想在run镜像时改变CMD命令执行时的参数 把run最后面的参数传给cmd命令 直接写在后面显然时不行的
		于是可以用ENTRYPOINT来运行CMD的内容 CMD作为参数传给ENTRYPOINT
		ENTRYPOINT [ "curl", "-s", "https://ip.cn" ] 
		此时docker run后面跟的参数 就会添加到ENTRYPOINT命令的后面 达到从外部改变CMD运行参数的效果
	应用二：
		在CMD命令之前 用ENTRYPOINT做一些准备工作 如执行个脚本 脚本参数为run传过来的
		ENTRYPOINT ["docker-entrypoint.sh"]
	
ENV 设置环境变量 格式有两种：
	ENV <key> <value>
	ENV <key1>=<value1> <key2>=<value2>...
ARG 构建参数
VOLUME 定义匿名卷 格式为：
	VOLUME ["<路径1>", "<路径2>"...]
	VOLUME <路径>
	当容器里有动态数据需要保存时 会保存在卷volume中 VOLUME有个默认的挂载目录 VOLUME /data
	也可以在运行时覆盖设置
	docker run -d -v mydata:/data xxxx
	将本地mydata挂载到容器/data文件夹
EXPOSE 声明端口 EXPOSE 仅仅是声明容器打算使用什么端口而已，并不会自动在宿主进行端口映射
	在运行时才会真正映射 docker run -p <宿主端口>:<容器端口>
WORKDIR 指定工作目录
	使用 WORKDIR 指令可以来指定工作目录（或者称为当前目录），以后各层的当前目录就被改为指定的目录，如该目录不存在，WORKDIR 会帮你建立目录
USER 指定当前用户
	格式：USER <用户名>[:<用户组>]
HEALTHCHECK 健康检查
	格式：
		HEALTHCHECK [选项] CMD <命令>：设置检查容器健康状况的命令
		HEALTHCHECK NONE：如果基础镜像有健康检查指令，使用这行可以屏蔽掉其健康检查指令
ONBUILD 为他人做嫁衣裳
	格式：ONBUILD <其它指令>。
	ONBUILD 是一个特殊的指令，它后面跟的是其它指令，比如 RUN, COPY 等，而这些指令，在当前镜像构建时并不会被执行。只有当以当前镜像为基础镜像，去构建下一级镜像的时候才会被执行。
###多阶段构建
FROM golang:1.9-alpine as builder

RUN apk --no-cache add git

WORKDIR /go/src/github.com/go/helloworld/

RUN go get -d -v github.com/go-sql-driver/mysql

COPY app.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest as prod

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=0 /go/src/github.com/go/helloworld/app .

CMD ["./app"]

FROM golang:1.9-alpine as builder 用as为某一阶段命名
$ docker build --target builder -t username/imagename:tag .  可以单独指定生成某一阶段镜像
COPY --from=0 /go/src/github.com/go/helloworld/app . 从某一阶段复制内容到现阶段 --form=0 0代表阶段索引号 阶段从0开始
$ COPY --from=nginx:latest /etc/nginx/nginx.conf /nginx.conf 也可复制任意镜像中的内容放到当前镜像构建阶段


可以借助前一个镜像生成 将前一个镜像生成的产物 复制到下一个镜像内
由此可看 go微服务可以有两种编译方式
1、本地编译 把编译好的可执行文件复制到镜像里
2、镜像内编译 编译好后复制到要生成的镜像
考虑用第二种 因为之后开发中不一定只有go环境 还可能有node等环境
如果本地编译又要好几步完成 索性放到镜像里编译 可能每次都要复制代码到镜像会有些慢

实践了下 放到镜像里编译 实现起来比较麻烦 主要是依赖包的问题
镜像里并没有程序依赖包 所以每次编译都要下载安装依赖包会很慢 而且每次都是下载最新的依赖包 有可能会出从 所以还是放到本地编译 把运行文件放到镜像里

###docker compose
编写 docker-compose.yml文件
 docker-compose up 运行docker-compose