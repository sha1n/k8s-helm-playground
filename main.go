package main

import (
	"github.com/sha1n/k8s-helm-playground/http"
	"github.com/sha1n/k8s-helm-playground/sys"
	"github.com/sha1n/k8s-helm-playground/web"
	"log"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	server := createHttpServer(8080)
	server.StartAsync()
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
