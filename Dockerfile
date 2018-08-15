FROM alpine:3.7

RUN apk update

COPY bin/echo-server /app/echo-server

WORKDIR /app

RUN chmod +x echo-server

EXPOSE 8080

CMD ["/app/echo-server"]
