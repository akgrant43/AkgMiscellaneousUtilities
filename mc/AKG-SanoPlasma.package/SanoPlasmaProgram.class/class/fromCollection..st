instance creation
fromCollection: aCollection
	"Answer an instance of the receiver derived from the supplied collection,
	which is a csv record in SanoPlasma custom.csv format"

	^self new 
		name: (aCollection at: 1);
		runningTime: (aCollection at: 3) asNumberOrNil;
		notes: (aCollection at: 4);
		addFrequencies: (aCollection at: 5);
		organ: (aCollection at: 6);
		illness: (aCollection at: 7);
		dwell: (aCollection at: 8) asNumberOrNil;
		yourself.