instance creation
on: aFileReference sanoPlasma: aSanoPlasma
	"Answer an instance of the receiver for the supplied file and equipment"

	^self new 
		fileReference: aFileReference asFileReference;
		sanoPlasma: aSanoPlasma;
		yourself