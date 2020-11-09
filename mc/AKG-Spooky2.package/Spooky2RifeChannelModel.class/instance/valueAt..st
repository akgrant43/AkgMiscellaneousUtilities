accessing
valueAt: time 
	"Answer the receiver's frequency in Hz at the supplied time (an integer seconds)"

	^ (function valueAt: time) + frequencyOffset