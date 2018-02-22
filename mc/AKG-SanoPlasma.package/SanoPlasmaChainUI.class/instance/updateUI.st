private
updateUI

	| presets |

	nameInput text: chain name.
	presets := chain presets.
	presetList items: presets.
	( presets isNotEmpty and: [ currentSelection first isNil ] ) ifTrue: [ 
		self presetSelected: presets first.
		self spSelected: presets first settings ].
