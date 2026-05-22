// Command app is the entry point for go-starter.
package main

import (
	"fmt"
	"os"

	"github.com/oleg-koval/go-starter/greet"
)

// Injected at build time via -ldflags.
var (
	version = "dev"
	commit  = "none"
	date    = "unknown"
)

func main() {
	if len(os.Args) > 1 && os.Args[1] == "version" {
		fmt.Printf("app %s (%s) built %s\n", version, commit, date)
		return
	}
	name := "world"
	if len(os.Args) > 1 {
		name = os.Args[1]
	}
	fmt.Println(greet.Hello(name))
}
