// Package greet contains internal helpers used only by this module.
// External modules cannot import packages under internal/.
package greet

import "fmt"

// format returns a greeting string — not exported outside this module.
func format(name string) string {
	return fmt.Sprintf("Hello, %s!", name)
}
