instance creation
fromName: fileName stream: aStream

	| files header line |

	header := ''.
	line := aStream nextLine.
	files := Array streamContents: [ :stream |
		[ line isNil ] whileFalse: [
			(#($# $%) includes: line first) ifTrue: 
				[ header := String streamContents: [ :headertream |
						headertream
							<< header;
							nextPut: Character cr;
							<< line ] ]
			ifFalse:
				[ stream nextPut: (HashDeepFile fromString: line) ].
			line := aStream nextLine ] ].
	^self new 
		fileName: fileName;
		files: files;
		header: header;
		yourself