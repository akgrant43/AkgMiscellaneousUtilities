instance creation
on: aFileReference
	"Answer an instance of the receiver for the supplied file"

	^self new 
		fileReference: aFileReference asFileReference;
		sanoPlasma: SanoPlasma default;
		yourself