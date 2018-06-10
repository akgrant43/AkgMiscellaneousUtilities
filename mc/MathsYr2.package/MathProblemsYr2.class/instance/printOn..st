printing
printOn: stream
	"Answer the string representing the list of problems"

	| generatorSize generator line |

	generatorSize := generators size.
	problemCount timesRepeat: [ 
		line := String streamContents: [ :lineStream |
			columns timesRepeat: [ 
				generator := generators at: (1 to: generatorSize) atRandom.
				lineStream nextPutAll: (generator next padRightTo: 40) ] ].
		line := line trimRight.
		stream 
			<< line;
			cr; cr. ].