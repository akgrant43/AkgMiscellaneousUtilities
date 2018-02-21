accessing
allChains
	"Answer a flat collection of all the receiver's presets"

	| presets |

	presets := ((self rootDirectory / 'Preset Collections') allFiles 
		select: [ :each | each extension = 'txt' ])
		collect: [ :each | 
			[ SanoPlasmaChain fromFile: each ]
				on: UTF8InvalidText, AssertionFailure
				do: [nil]].
	^presets select: [ :each | each isNotNil ].