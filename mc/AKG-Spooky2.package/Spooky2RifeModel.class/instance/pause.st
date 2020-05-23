operating
pause
	"Toggle the paused state of the programme"

	pauseBoolean 
		ifTrue: [ pauseSemaphore signal ].
	pauseBoolean := pauseBoolean not.