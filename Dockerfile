FROM golang:1.14.4-alpine3.12 as builder
WORKDIR $GOPATH/src/github.com/xanderstrike/resp/
RUN apk add --no-cache git
COPY . .
RUN mkdir /out
RUN mkdir /out/keystore
RUN GO111MODULE=on CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /out/resp

FROM scratch
LABEL maintainer="xanderstrike@gmail.com"
WORKDIR /app
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /out .
VOLUME /app/files/
EXPOSE 8000
ENTRYPOINT ["/app/resp"]
