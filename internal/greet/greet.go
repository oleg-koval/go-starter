// Package greet provides simple greeting helpers.
package greet

import "fmt"

// Hello returns a friendly greeting addressed to name.
func Hello(name string) string {
	return fmt.Sprintf("Hello, %s!", name)
}
