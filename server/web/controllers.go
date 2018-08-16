package web

import "github.com/gin-gonic/gin"

func HandleHealthCheck(c *gin.Context) {
	c.Status(200)
}

func HandleEcho(c *gin.Context) {
	c.Request.Write(c.Writer)
}
