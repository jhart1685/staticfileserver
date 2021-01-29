# Binary Build
FROM golang:1.14.12 as gobuild

WORKDIR /go/src/github.com/jhart1685/staticfileserver
COPY . .
RUN CGO_ENABLED=0 GOOS=linux /usr/local/go/bin/go build -a

# Image Build
FROM alpine
COPY bigfile /bigfile

COPY --from=gobuild /go/src/github.com/jhart1685/staticfileserver/staticfileserver /staticfileserver
ENTRYPOINT ["/staticfileserver"]
