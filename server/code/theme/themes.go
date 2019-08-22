

// Package theme includes theme related manipulations.
package theme

import (
	"os"

	"github.com/b3log/gulu"
)

// Logger
var logger = gulu.Log.NewLogger(os.Stdout)

// DefaultTheme represents the default theme name.
const DefaultTheme = "Littlewin"

// Themes saves all theme names.
var Themes []string

// Load loads themes.
func Load() {
	f, _ := os.Open("theme/x")
	names, _ := f.Readdirnames(-1)
	f.Close()

	for _, name := range names {
		if !gulu.Rune.IsNumOrLetter(rune(name[0])) {
			continue
		}

		Themes = append(Themes, name)
	}

	logger.Debugf("loaded [%d] themes", len(Themes))
}
