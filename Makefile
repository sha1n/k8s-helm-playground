NOCOL=\x1b[0m
GREEN=\x1b[32;01m
RED=\x1b[31;01m
YELLOW=\x1b[33;01m

define print_title
	@echo "---"
	@echo "--- $(GREEN)$1$(NOCOL)"
	@echo "---"
endef

default:
	go get -t ./...
	make test

test:
	$(call print_title, Running tests...)
	go test -v `go list ./...`

build:
	$(call print_title,Building binaries...)
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server/bin/echo-server github.com/sha1n/k8s-helm-playground/server
	$(call print_title,Building docker image...)
	docker build -t sha1n/echo-server server

prepare:
	$(call print_title,Preparing go dependencies...)
	dep ensure -v

format:
	$(call print_title,Formatting go sources...)
	gofmt -s -w server

lint:
	$(call print_title,Lint...)
	gofmt -d server

run:
	go run server/bootstrap.go

push-docker:
	$(call print_title,Publishing docker image...)
	docker push sha1n/echo-server:latest

run-docker:
	docker run -d -p 8080:8080 sha1n/echo-server

release:
	make prepare
	make format
	make lint
	make test
	make build
	make push-docker