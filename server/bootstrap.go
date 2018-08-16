package main

import (
	"github.com/sha1n/k8s-helm-playground/server/config"
	"github.com/sha1n/k8s-helm-playground/server/http"
	"github.com/sha1n/k8s-helm-playground/server/sys"
	"github.com/sha1n/k8s-helm-playground/server/web"
	"log"
	"os"
	"os/signal"
	"syscall"
)

func init() {
	log.SetFlags(log.Ldate | log.Lmicroseconds | log.Lshortfile | log.Ltime | log.LUTC)
}

func main() {
	server := createHttpServer(8080)
	server.StartAsync()

	config.StartConfigMonitor()

	awaitShutdownSig()
}

func awaitShutdownSig() {
	quitChannel := make(chan os.Signal)
	signal.Notify(quitChannel, syscall.SIGINT, syscall.SIGTERM)

	log.Println("Waiting for shutdown signal...")

	<-quitChannel
}

func createHttpServer(port int) http.Server {
	server := http.
		NewServer(port).
		WithGetHandler("/health", web.HandleHealthCheck).
		WithPostHandler("/echo", web.HandleEcho).
		WithGetHandler("/echo", web.HandleEcho).
		Build()

	stopServerAsync := func() {
		server.StopAsync()
	}

	log.Println("Registering signal listeners for graceful HTTP server shutdown..")
	sys.RegisterShutdownHook(sys.NewSignalHook(syscall.SIGTERM, stopServerAsync))
	sys.RegisterShutdownHook(sys.NewSignalHook(syscall.SIGKILL, stopServerAsync))

	return server
}
