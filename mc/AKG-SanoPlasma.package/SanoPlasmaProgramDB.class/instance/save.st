actions
save
	"Write the receiver back to the database"

	| csv |
	
	fileName writeStreamDo: [ :stream |
		csv := NeoCSVWriter on: stream.
		csv nextPutAll: self programs ]