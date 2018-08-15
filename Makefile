test:
	echo Running tests...
	go test -v `go list ./...`

build:
	echo Building binaries...
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o bin/echo-server github.com/sha1n/k8s-helm-playground
	echo Building docker image...
	docker build -t sha1n/echo-server .

prepare:
	echo Preparing dependencies...
	dep ensure -v

format:
	echo Formatting source code...
	gofmt -s -w .

lint:
	echo Running lint...
	gofmt -d .

run:
	go run main.go

push-docker:
	echo Pushing docker image to registry...
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