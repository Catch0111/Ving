

package util

import (
	"testing"
)

func TestRandomAvatarData(t *testing.T) {
	data := RandAvatarData()
	if nil == data {
		t.Error("generate random avatar data failed")

		return
	}
}