// Command app is the entry point for <PROJECT_NAME>.
package main

import (
	"fmt"
	"os"

	"github.com/oleg-koval/<PROJECT_NAME>/internal/greet"
)

func main() {
	name := "world"
	if len(os.Args) > 1 {
		name = os.Args[1]
	}
	fmt.Println(greet.Hello(name))
}
