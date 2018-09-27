private
getRemoved
	"Build the set of methods that exist in the system and are removed by the receivers file"

	^Array streamContents: [ :stream | ]