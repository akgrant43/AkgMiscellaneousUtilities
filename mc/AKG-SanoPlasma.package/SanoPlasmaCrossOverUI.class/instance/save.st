private
save
	"Save the receivers preset & program"

	| program preset |

	self validConfiguration ifFalse: [ ^UIManager default 
			alert: 'Invalid Configuration'
			title: 'SanoPlasma CrossOver' ].
	program := SanoPlasmaProgram new 
					name: self name;
					frequencies: self frequenciesDefinition;
					dwell: self timeInSeconds;
					yourself.
	preset := SanoPlasmaPreset new 
					yourself.