private - event handling
processClickEvent: event
	"Set the value holder based on where the user clicked"
	| percentage |

	percentage := ((event position x - self boundsInWindow origin x) /
				(self bounds extent x)) asFloat.

	valueHolder value: percentage.
