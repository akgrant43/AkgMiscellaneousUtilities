private
save
	"Save the receivers preset & program"

	| preset |

	self validConfiguration ifFalse: [ ^UIManager default 
			alert: 'Invalid Configuration'
			title: 'SanoPlasma CrossOver' ].
	frequencyRange
		fromFrequency: (self fromFrequency * 1000) rounded;
		toFrequency: (self toFrequency * 1000) rounded;
		dwell: self timeInSeconds.
	program
		name: self name;
		dwell: self timeInSeconds.
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