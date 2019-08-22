

package util

import "testing"

func TestIsReservedPath(t *testing.T) {
	if !IsReservedPath("/api") {
		t.Errorf("[/api] is a reserved path")

		return
	}
	if IsReservedPath("/test") {
		t.Errorf("[/test] is not a reserved path")
	}
}
