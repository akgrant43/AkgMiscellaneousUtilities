initialization
setButtonState
	"Enable / Disable all buttons as appropriate"
	| stopped |

	stopped := rifeModel isStopped.
	stop enabled: stopped not.
	play enabled: stopped.
	pause enabled: (rifeModel isRunning or: [ rifeModel isPaused ]).
	hold enabled: (rifeModel isRunning or: [rifeModel isHeld ]).
	forward enabled: rifeModel isHeld.
	backward enabled: rifeModel isHeld.