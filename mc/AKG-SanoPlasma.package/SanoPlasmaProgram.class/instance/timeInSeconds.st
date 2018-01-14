accessing
timeInSeconds
	"Answer the total time in seconds"

	^frequencies inject: 0 into: [ :sum :freq | sum + 
		(freq dwell ifNil: [dwell]) ]