private - changed
fileSelected: aFileReference

	| chain |

	aFileReference ifNil: [ ^self ].
	chain := SanoPlasmaChain fromFile: aFileReference.
	self presetsList items: chain presets.
	self presetSelected: self presetsList selectedItem