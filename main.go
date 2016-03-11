package main

import (
	"flag"
	"github.com/codegangsta/negroni"
	"log"
	"net/http"
)

var address = flag.String("b", ":3000", "bind the address")

func main() {
	flag.Parse()
	n := negroni.Classic()
	n.Use(negroni.NewStatic(http.Dir("./public")))

	if err := http.ListenAndServe(*address, n); err != nil {
		log.Fatal(err)
	}
}
