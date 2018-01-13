accessing
fileNameIn: aDirectory
	"Answer the receivers FileReference"

	^aDirectory / (name, '.txt')