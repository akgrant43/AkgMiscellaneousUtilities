initialization
setButtonState
	"Enable / Disable all buttons as appropriate"
	| stopped |

	stopped := rifeModel isStopped.
	stop enabled: stopped not.
	play enabled: stopped.
	pause enabled: (rifeModel isRunning or: [ rifeModel isPaused ]).
	(pause look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: 
		(rifeModel isPaused
			ifTrue: [ Color red ]
			ifFalse: [ Color white ]).	
	hold enabled: (rifeModel isRunning or: [rifeModel isHeld ]).
	(hold look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: 
		(rifeModel isHeld
			ifTrue: [ Color red ]
			ifFalse: [ Color white ]).	
	forward enabled: rifeModel isHeld.
	backward enabled: rifeModel isHeld.