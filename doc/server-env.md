##服务端环境搭建

服务器采用本地编译 docker部署
本地编译各个微服务的linux版本
每个微服务一个容器 

go 环境安装
linux：
    获取最新的软件包源，并添加至当前的apt库
    `add-apt-repository ppa:longsleep/golang-backports`
    更新 apt库
    `apt-get update`
    安装go
    `sudo apt-get install golang-go`
    鉴定是否安装成功
    `go version`
    运行 `go env` 查看GOPATH路径

安装好后 要配置环境变量
$GOPATH
$GOBIN
不然kratos tool 一些工具找不到路径
mac下 vim ~/.bash_profile
export GOPATH=/usr/go
export GOBIN=/usr/go/bin
source ~/.bash_profile

linux下 vim ~/.bashrc
source ~/.bashrc

