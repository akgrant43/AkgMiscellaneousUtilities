private
save
	"Save the receivers preset & program"

	| program settings preset |

	self validConfiguration ifFalse: [ ^UIManager default 
			alert: 'Invalid Configuration'
			title: 'SanoPlasma CrossOver' ].
	program := SanoPlasmaProgram new 
					name: self name;
					frequencies: self frequenciesDefinition;
					dwell: self timeInSeconds;
					yourself.
	settings := SanoPlasmaSettings new
					yourself.
	preset := SanoPlasmaPreset new 
					settings: settings;
					add: program;
					yourself.
	preset saveIn: self presetDirectory.
	sanoPlasma 
		programDB addOrReplace: program;
		save.