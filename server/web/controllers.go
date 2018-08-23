package web

import (
	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"time"
)

var startupTime = time.Now()

func HandleHealthCheck(c *gin.Context) {
	c.Status(200)
}

func HandleReadinessCheck(c *gin.Context) {
	// getting ready only after 20 seconds
	if time.Now().Unix() >= (startupTime.Add(time.Second * 20).Unix()) {
		c.Status(200)
	} else {
		logrus.Warn("Server not ready yet...")
		c.Status(503)
	}
}

func HandleEcho(c *gin.Context) {
	c.Request.Write(c.Writer)
}
