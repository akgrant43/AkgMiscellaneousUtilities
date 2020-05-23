accessing
duration: aDuration
	"Set the duration in seconds"

	duration := aDuration asSeconds asFloat.
	self assert: duration >= 10.
