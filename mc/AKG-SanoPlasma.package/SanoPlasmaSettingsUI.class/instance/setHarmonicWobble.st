private
setHarmonicWobble
	"Update the Harmonic Wobble in the receivers settings from the widget"

	| index name |

	index := harmonicWobbleWidget selectedIndex.
	name := SanoPlasmaSettings harmonicWobbleChoices at: index.
	self settingsAt: 'Harmonic Wobble' put: name.