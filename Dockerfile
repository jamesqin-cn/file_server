FROM golang AS builder
WORKDIR /go/src/github.com/jamesqin-cn/file_server/
ADD . .
RUN go get -v && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .


FROM alpine
COPY --from=builder /go/src/github.com/jamesqin-cn/file_server/app /bin/file_server
ADD entrypoint.sh /bin/
RUN chmod +x /bin/file_server && chmod +x /bin/entrypoint.sh
ENTRYPOINT ["/bin/entrypoint.sh"]
EXPOSE 80
