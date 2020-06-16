events
updateModel 
	| frequencyString |

	frequencyString := rifeModel isStopped 
		ifTrue: [ '<not running>' ]
		ifFalse: [ (rifeModel frequency / 1000.0) printShowingDecimalPlaces: 3 ].
	frequency text: (frequencyString asRopedText fontSize: 20)