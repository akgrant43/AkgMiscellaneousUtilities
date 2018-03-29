private
columnsFor: aFileReference
	"Answer the array of columns to be used in the directory list, i.e.
	the filename and encoded report date"

	^{
		aFileReference basename.
		"self filenameDate: aFileReference."
		aFileReference creationTime asString.
	}