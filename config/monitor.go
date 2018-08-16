package config

import (
	"github.com/sha1n/k8s-helm-playground/sys"
	"io/ioutil"
	"log"
	"syscall"
	"time"
)

var currentValue = ""

func init() {
	currentValue, err := loadConfig()
	if err == nil {
		log.Println("Initial config value is", currentValue)
	}
	log.Println("Initial config value is", currentValue)
}

func StartConfigMonitor() {
	log.Println("Starting config monitor...")
	exitChannel := make(chan struct{})
	signalExit := func() {
		exitChannel <- struct{}{}
	}
	sys.NewSignalHook(syscall.SIGKILL, signalExit)
	sys.NewSignalHook(syscall.SIGTERM, signalExit)

	go func() {
		for {
			timer := time.NewTimer(time.Second * 5)
			select {
			case <-exitChannel:
				log.Println("Shutting down config monitor...")
				break

			case <-timer.C:
			}

			value, err := loadConfig()

			if err == nil && value != currentValue {
				log.Println("Config file changed from [", currentValue, "] to [", value, "]")
				currentValue = value
			}
		}
	}()
}

func loadConfig() (rtn string, err error) {
	bytes, err := ioutil.ReadFile("/configs/test-config.txt")

	if err != nil {
		log.Println("Failed to load config file", err)
	} else {
		rtn = string(bytes)
	}

	return rtn, err
}
