accessing
pages: pageCount
	"Set the reportFrequencyCount to the number matching the number of pages"

	^self reportFrequencyCount: (self class pageToLineCount at: pageCount)