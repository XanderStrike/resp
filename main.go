package main

import (
	"log"
	"net/http"
	"os"
	"strconv"
)

func main() {
	http.HandleFunc("/", foo)
	log.Printf("Server started")
	_ = http.ListenAndServe(":8080", nil)
}

func foo(w http.ResponseWriter, r *http.Request) {
	log.Printf("Got a request...")
	w.Header().Set("Server", "A Go Web Server")
	code, _ := strconv.Atoi(os.Getenv("RESPONSE_STATUS"))
	w.WriteHeader(code)
}
