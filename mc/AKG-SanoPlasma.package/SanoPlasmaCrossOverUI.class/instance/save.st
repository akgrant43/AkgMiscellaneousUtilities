private
save
	"Save the receivers preset & program"

	| frequencyRange program settings preset |

	self validConfiguration ifFalse: [ ^UIManager default 
			alert: 'Invalid Configuration'
			title: 'SanoPlasma CrossOver' ].
	frequencyRange := SanoPlasmaFrequencyRange new 
					fromFrequency: (self fromFrequency * 1000) rounded;
					toFrequency: (self toFrequency * 1000) rounded;
					dwell: self timeInSeconds;
					yourself.
	program := SanoPlasmaProgram new 
					name: self name;
					addFrequency: frequencyRange;
					dwell: self timeInSeconds;
					yourself.
	settings := SanoPlasmaSettings new
					yourself.
	preset := SanoPlasmaPreset new 
					name: self name;
					settings: settings;
					add: program;
					yourself.
	(preset fileNameIn: self presetDirectory) exists ifTrue: [ 
		(UIManager default confirm: self name, ' already exists.  Overwrite?' label: 'SanoPlasma')
			ifFalse: [ ^self ] ].
	preset saveIn: self presetDirectory.
	sanoPlasma programDB 
		addOrReplace: program;
		save.