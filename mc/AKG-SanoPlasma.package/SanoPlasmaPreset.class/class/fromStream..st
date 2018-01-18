instance creation
fromStream: aStream
	"Answer a new instance of the receiver parsed from the supplied stream"

	| preset settings |

	settings := SanoPlasmaSettings fromStream: aStream.
	preset := self new 
		settings: settings;
		name: (settings at: 'PresetName' ifAbsent: [ '' ]);
		add: (SanoPlasmaProgram new 
					addFrequencies: (settings at: 'List4');
					name: (settings at: 'Program Name');
					yourself);
		yourself.
	^preset