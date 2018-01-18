tests
testWriteOn

	| frequencyRange program settings preset presetString |

	frequencyRange := SanoPlasmaFrequencyRange new
		fromFrequency: 123000;
		toFrequency: 456000;
		dwell: 789;
		yourself.
	program := SanoPlasmaProgram new 
		name: 'Program Names';
		addFrequency: frequencyRange;
		dwell: 890;
		yourself.
	settings := SanoPlasmaSettings new.
	preset := SanoPlasmaPreset new 
		name: 'Preset Name';
		settings: settings;
		add: program;
		yourself.

	presetString := String streamContents: [ :stream | preset writeOn: stream ].
	self assert: presetString equals: self template1.