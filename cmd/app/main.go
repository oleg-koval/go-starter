// Command app is the entry point for go-starter.
package main

import (
	"fmt"
	"os"

	"github.com/oleg-koval/go-starter/internal/greet"
)

func main() {
	name := "world"
	if len(os.Args) > 1 {
		name = os.Args[1]
	}
	fmt.Println(greet.Hello(name))
}
