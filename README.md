# File Server

HTTP file server for static file

## Start
```
docker run --restart=always -d \
    -p <expose_port>:80 \
    -v <data_dir>:/data \
    --name file_server \
    file_server
```
