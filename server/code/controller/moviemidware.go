package controller

import (
	"os"

	"github.com/b3log/gulu"
	"github.com/gin-gonic/gin"
)

// Logger
var logger = gulu.Log.NewLogger(os.Stdout)

// DataModel represents data model.
type DataModel map[string]interface{}

func notFound(c *gin.Context) {
	// t, err := template.ParseFiles("console/dist/start/index.html")
	// if nil != err {
	// 	logger.Errorf("load 404 page failed: " + err.Error())
	// 	c.String(http.StatusNotFound, "load 404 page failed")

	// 	return
	// }

	// c.Status(http.StatusNotFound)
	// t.Execute(c.Writer, nil)
}
