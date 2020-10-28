as yet unclassified
processClickEvent: event
	"Set the time based on where the user clicked"
	| percentage time |

	percentage := ((event position x - self bounds position x) /
				(self bounds extent x)) asFloat.
	time := self rifeModel runTime * percentage.
	self rifeModel adjustTime: time - self rifeModel time.