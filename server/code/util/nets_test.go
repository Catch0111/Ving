

package util

import "testing"

func TestIsIP(t *testing.T) {
	if !IsIP("8.8.8.8") {
		t.Errorf("[8.8.8.8] is an IP")

		return
	}

	if IsIP("is.not.an.ip") {
		t.Errorf("[is.not.an.ip] is not an IP")

		return
	}

	if !IsIP("127.0.0.1") {
		t.Errorf("[127.0.0.1] is an IP")

		return
	}

	if IsIP("localhost") {
		t.Errorf("[localhost] is not an IP")

		return
	}
}

func TestIsDomain(t *testing.T) {
	if !IsDomain("b3log.org") {
		t.Errorf("[b3log.org] is a daomin")

		return
	}

	if IsDomain("localhost") {
		t.Errorf("[localhost] is not a domain")

		return
	}

	if IsDomain("8.8.8.8") {
		t.Errorf("[8.8.8.8] is not a domain")
	}
}

func TestIsBot(t *testing.T) {
	if !IsBot("Sym") {
		t.Errorf("[Sym] is not a bot")

		return
	}
}