package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"time"

	"github.com/golang/glog"
)

var (
	host     = flag.String("host", ":9066", "listen ip and port")
	doc_root = flag.String("doc_root", "/data", "document root")
)

func Log(handler http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		glog.Infoln(r.Method, r.URL, r.RemoteAddr)
		handler.ServeHTTP(w, r)
	})
}

func main() {
	flag.Parse()

	http.HandleFunc("/echo", func(w http.ResponseWriter, r *http.Request) {
		echoStr := r.URL.Query().Get("str")
		if echoStr == "" {
			echoStr = "ok"
		}
		fmt.Fprintf(w, echoStr)
	})

	http.HandleFunc("/index.html", func(w http.ResponseWriter, r *http.Request) {
		file := *doc_root + r.URL.Path
		content, err := ioutil.ReadFile(file)
		if err != nil {
			fmt.Fprintf(w, "Welcome! Current timestamp is %v", time.Now().Unix())
			return
		}
		fmt.Fprintf(w, string(content))
		return
	})

	http.Handle("/", http.FileServer(http.Dir(*doc_root)))
	if err := http.ListenAndServe(*host, Log(http.DefaultServeMux)); err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
