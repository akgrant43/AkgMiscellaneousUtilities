accessing
filenameAt: freq
	"Answer the file name used for the specified frequency"

	^String streamContents: [ :fstream |
		fstream << (self programNameAt: freq).
		namePostfix ifNotEmpty: [ 
			fstream
				<< ' ';
				<< namePostfix ].
		fstream
			<< '.txt' ].
