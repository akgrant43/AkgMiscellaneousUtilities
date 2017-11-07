instance creation
fromString: aString
	"Answer a new instance of the receiver from the supplied string.
	The string is assumed to be a line from a hashdeep file, i.e. CSV with:
	1. File Size
	2. Hash1
	3. Hash2
	4. File Name"

	| size fileName hash1 hash2 index lastIndex |

	index := aString indexOf: $,.
	self assert: index > 1.
	size := (aString copyFrom: 1 to: index-1) asNumber.
	lastIndex := index.
	index := aString indexOf: $, startingAt: lastIndex+1.
	hash1 := aString copyFrom: lastIndex+1 to: index-1.
	lastIndex := index.
	index := aString indexOf: $, startingAt: lastIndex+1.
	hash2 := aString copyFrom: lastIndex+1 to: index-1.
	fileName := aString copyFrom: index+1 to: aString size.
	^self new 
		fileName: fileName;
		fileSize: size;
		hash1: hash1;
		hash2: hash2;
		yourself.