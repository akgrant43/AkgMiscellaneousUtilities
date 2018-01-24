private - changed
fileSelected: aFileReference

	| chain |

	aFileReference ifNil: [ ^self ].
	chain := SanoPlasmaChain fromFile: aFileReference.
	self presetsList items: chain presets.
	"chain presets ifEmpty: [ ^self ].
	self presetsList setIndex: 1."
