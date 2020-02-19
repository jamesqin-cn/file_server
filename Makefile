CURR_DIR := $(shell cd `pwd` && pwd)
OUTPUT := file_server

$(OUTPUT):
	go get -v
	CGO_ENABLED=0 go build -a -installsuffix cgo -o $(OUTPUT) .

build:
	docker run -it --rm -v $(CURR_DIR):/go/src/git.oa.com/svc/$(OUTPUT)_proj/ golang bash -c "cd /go/src/git.oa.com/svc/$(OUTPUT)_proj; make clean; make"

clean:
	rm -f $(OUTPUT)
