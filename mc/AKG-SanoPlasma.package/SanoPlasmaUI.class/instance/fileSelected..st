private - changed
fileSelected: aFileReference

	aFileReference ifNil: [ ^self ].
	inRebuild ifTrue: [ ^self ].
	currentSelection at: 2 put: aFileReference.
	currentSelection
		at: 3 put: nil;
		at: 4 put: nil.
	selectedChain := SanoPlasmaChain fromFile: aFileReference.
	chainUI chain: selectedChain.