package util

import (
	"time"
)

// CurrentMillisecond returns the current time in millisecond.
func CurrentMillisecond() uint64 {
	return uint64(time.Now().UnixNano() / int64(time.Millisecond))
}
