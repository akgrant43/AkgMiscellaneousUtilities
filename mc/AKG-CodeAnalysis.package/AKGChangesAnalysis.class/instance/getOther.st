private
getOther
	"Answer any other chunks"

	| newOther |
	newOther := externalChanges copy.
	newOther 	
		removeAll: self added;
		removeAll: self changed;
		removeAll: self removed;
		removeAll: self unchanged.
	^newOther