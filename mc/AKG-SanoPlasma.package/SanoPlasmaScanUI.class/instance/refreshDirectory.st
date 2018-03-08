private
refreshDirectory
	"Update the list of results"

	self directoryList items: self scanDirectory sortedFiles.