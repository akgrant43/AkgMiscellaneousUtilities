private - changed
fileSelected: aFileReference

	| chain |

	aFileReference ifNil: [ ^self ].
	inRebuild ifTrue: [ ^self ].
	currentSelection at: 2 put: aFileReference.
	currentSelection
		at: 3 put: nil;
		at: 4 put: nil.
	chain := SanoPlasmaChain fromFile: aFileReference.
	self presetsList items: chain presets.
	"chain presets ifEmpty: [ ^self ].
	self presetsList setIndex: 1."
