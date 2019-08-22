package main

import (
	"server/controller"
	"server/i18n"
	"server/model"
	"server/service"
	"io"
	"math/rand"
	"net/http"
	"os"
	"time"

	"github.com/b3log/gulu"
	"github.com/gin-gonic/gin"
)

// Logger
var logger *gulu.Logger

func init() {
	rand.Seed(time.Now().UTC().UnixNano())

	gulu.Log.SetLevel("info")
	logger = gulu.Log.NewLogger(os.Stdout)

	model.LoadConf()
	i18n.Load()
	replaceServerConf()
	if "dev" == model.Conf.RuntimeMode {
		gin.SetMode(gin.DebugMode)
	} else {
		gin.SetMode(gin.ReleaseMode)
	}
	gin.DefaultWriter = io.MultiWriter(os.Stdout)
}

func main() {
	db, err := service.ConnectDB(model.Conf.MongoConnect, model.Conf.MongoDBName)

	if err != nil {
		logger.Error("连接数据库失败")
		panic(err)
	}
	defer db.Close()

	router := controller.MapRoutes()
	server := &http.Server{
		Addr:    "0.0.0.0:" + model.Conf.Port,
		Handler: router,
	}

	handleSignal(server)

	logger.Infof("Server (v%s) is running [%s]", model.Version, model.Conf.Server)
	if err := server.ListenAndServe(); nil != err {
		logger.Fatalf("listen and serve failed: " + err.Error())
	}
}

// handleSignal handles system signal for graceful shutdown.
func handleSignal(server *http.Server) {
	// c := make(chan os.Signal)
	// signal.Notify(c, syscall.SIGINT, syscall.SIGQUIT, syscall.SIGTERM)

	// go func() {
	// 	s := <-c
	// 	logger.Infof("got signal [%s], exiting pipe now", s)
	// 	if err := server.Close(); nil != err {
	// 		logger.Errorf("server close failed: " + err.Error())
	// 	}

	// 	service.DisconnectDB()

	// 	logger.Infof("Pipe exited")
	// 	os.Exit(0)
	// }()
}

func replaceServerConf() {
	// path := "theme/sw.min.js.tpl"
	// if gulu.File.IsExist(path) {
	// 	data, err := ioutil.ReadFile(path)
	// 	if nil != err {
	// 		logger.Fatal("read file [" + path + "] failed: " + err.Error())
	// 	}
	// 	content := string(data)
	// 	content = strings.Replace(content, "http://server.tpl.json", model.Conf.Server, -1)
	// 	content = strings.Replace(content, "http://staticserver.tpl.json", model.Conf.StaticServer, -1)
	// 	content = strings.Replace(content, "${StaticResourceVersion}", model.Conf.StaticResourceVersion, -1)
	// 	writePath := strings.TrimSuffix(path, ".tpl")
	// 	if err = ioutil.WriteFile(writePath, []byte(content), 0644); nil != err {
	// 		logger.Fatal("replace sw.min.js in [" + path + "] failed: " + err.Error())
	// 	}
	// }

	// if gulu.File.IsExist("console/dist/") {
	// 	err := filepath.Walk("console/dist/", func(path string, f os.FileInfo, err error) error {
	// 		if strings.HasSuffix(path, ".tpl") {
	// 			data, err := ioutil.ReadFile(path)
	// 			if nil != err {
	// 				logger.Fatal("read file [" + path + "] failed: " + err.Error())
	// 			}
	// 			content := string(data)
	// 			content = strings.Replace(content, "http://server.tpl.json", model.Conf.Server, -1)
	// 			content = strings.Replace(content, "http://staticserver.tpl.json", model.Conf.StaticServer, -1)
	// 			writePath := strings.TrimSuffix(path, ".tpl")
	// 			if err = ioutil.WriteFile(writePath, []byte(content), 0644); nil != err {
	// 				logger.Fatal("replace server conf in [" + writePath + "] failed: " + err.Error())
	// 			}
	// 		}

	// 		return err
	// 	})
	// 	if nil != err {
	// 		logger.Fatal("replace server conf in [theme] failed: " + err.Error())
	// 	}
	// }
}
