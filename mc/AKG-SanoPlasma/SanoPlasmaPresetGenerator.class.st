"
SanoPlasmaPresetGenerator generates a custom.csv (custom programs) and presets for running the plasma and contacts in crossover fashion, i.e. the plasma runs from the start frequence to the end frequency, and the contacts run in the opposite direction.

The custom programs are not required to use the presets.

SanoPlasmaPresetGenerator new
	startFreq: 400000;
	endFreq: 500000;
	stepFreq: 500;
	freqRange: 1000;
	programSeconds: 1800;
	namePrefix: 'Fr';
	outDir: '/dev/shm/sanoplasma';
	generate


By default, and as in the example above, the program frequency range for the plasma runs from low-to-high, and the contact frequency range runs from high-to-low.

The stepFreq is the increase in frequency (Hz) between each preset, e.g. in the above example the first preset will start at 400KHz, the second at 400.5kHz.

It is possible to generate programs where the plasma frequency range runs from high-to-low, e.g.:

SanoPlasmaPresetGenerator new
	startFreq: 2000;
	endFreq: 899500;
	stepFreq: 500;
	freqRange: -1000;
	programSeconds: 1200;
	namePrefix: 'Fr';
	namePostfix: 'down';
	outDir: '/dev/shm/sanoplasma';
	generate

The number of crossovers per program can also be specified with the crossoverCount and crossoverRange:

startFreq = 1000
freqRange = 1000
crossoverCount = 20
crossoverRange = 100

There will be 10 crossovers per chain, each running for 100 Hz.

| generator |
generator := SanoPlasmaPresetGenerator new
	startFreq: 1000;
	endFreq: 899000;
	stepFreq: 500;
	freqRange: 1000;
	crossoverCount: 20;
	crossoverRange: 100;
	programSeconds: 3000;
	namePrefix: 'Fr';
	outDir: '/dev/shm/sanoplasma/Step 1kHz Cross 20-100 50min Up';
	yourself.
generator settings
	at: 'Out 2 Voltage Multiplier' put: '3';
	at: 'Repeat each program' put: '3'.
generator generate.


A start or end frequency of 0 will be converted to 1 in the program, i.e. specifying 0 - 1000Hz will actually generate 1 - 1000Hz.
 
Internal Representation and Key Implementation Points.

Instance Variables
	startFreq:		<Integer>	Start frequency, must be positive
	endFreq:			<Integer> End frequency, must be positive
	freqRange:		<Integer> Frequency range for each chain.  Can be negative.
	programSeconds 	<Integer> The total number of seconds for the chain.
							i.e. each preset runs for programSeconds / crossoverCount
	crossoverCount: <Integer> Number of crossovers for each chain.  Default = 1.
	stepFreq:			<Integer> Frequency step amount for each chain.
	outDir:			<String>


Implementation Points
"
Class {
	#name : #SanoPlasmaPresetGenerator,
	#superclass : #Object,
	#instVars : [
		'startFreq',
		'endFreq',
		'stepFreq',
		'freqRange',
		'crossoverCount',
		'crossoverRange',
		'programSeconds',
		'outDir',
		'namePrefix',
		'namePostfix',
		'settings'
	],
	#category : 'AKG-SanoPlasma-Generator'
}

{ #category : #templates }
SanoPlasmaPresetGenerator class >> defaultTemplate [
	"Answer the default template"

	^self preset201712211429
]

{ #category : #history }
SanoPlasmaPresetGenerator class >> dj20180302 [
	<script>

	| generator settings |

	generator := self new
		startFreq: 2000;
		endFreq: 899500;
		stepFreq: 500;
		freqRange: -1000;
		programSeconds: 1200;
		namePrefix: 'Fr';
		namePostfix: 'down';
		outDir: '/dev/shm/sanoplasma/down';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Voltage Multiplier' put: '3'.
	generator generate.
]

{ #category : #history }
SanoPlasmaPresetGenerator class >> dj20180305 [
	"DJ: Up and Down sets.
	- Leave up out of preset name
	- 20 minute duration
	- No wobble
	- Repeat each program 3 times"
	<script>

	| generator settings |

	generator := self new
		startFreq: 1000;
		endFreq: 899500;
		stepFreq: 500;
		freqRange: 1000;
		programSeconds: 1200;
		namePrefix: 'Fr';
		namePostfix: '';
		outDir: '/dev/shm/sanoplasma/Step 1kHz 20min Up';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '3'.
	generator generate.


	generator := self new
		startFreq: 2000;
		endFreq: 899500;
		stepFreq: 500;
		freqRange: -1000;
		programSeconds: 1200;
		namePrefix: 'Fr';
		namePostfix: 'down';
		outDir: '/dev/shm/sanoplasma/Step 1kHz 20min Down';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '3'.
	generator generate.


]

{ #category : #history }
SanoPlasmaPresetGenerator class >> dj20180425 [
	"DJ: Up and Down sets.
	- 30 minute duration
	- No wobble
	- Repeat each program 3 times
	- Out 2 Offset 100%"
	<script>

	| generator settings |

	generator := self new
		startFreq: 1000;
		endFreq: 899500;
		stepFreq: 500;
		freqRange: 1000;
		crossoverCount: 10;
		crossoverRange: 100;
		programSeconds: 1800;
		namePrefix: 'Fr';
		namePostfix: '';
		outDir: '/dev/shm/sanoplasma/Step 1kHz Cross 10 Offset2 100 30min Up';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Offset' put: '100';
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '1'.
	generator generate.


	generator := self new
		startFreq: 2000;
		endFreq: 899500;
		stepFreq: 500;
		freqRange: -1000;
		programSeconds: 1800;
		crossoverCount: 10;
		crossoverRange: 100;
		namePrefix: 'Fr';
		namePostfix: 'down';
		outDir: '/dev/shm/sanoplasma/Step 1kHz Cross 10 Offset2 100 30min Down';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Offset' put: '100';
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '1'.
	generator generate.


]

{ #category : #history }
SanoPlasmaPresetGenerator class >> dj20180425b [
	"DJ: Up and Down sets.
	- 30 minute duration
	- No wobble
	- Repeat each program 1 times
	- Out 2 Offset 100%
	- Crossover at 100Hz mark (instead of 50Hz)"
	<script>

	| generator settings |

	generator := self new
		startFreq: 1050;
		endFreq: 899500;
		stepFreq: 500;
		freqRange: 1000;
		crossoverCount: 10;
		crossoverRange: 100;
		programSeconds: 1800;
		namePrefix: 'Fr';
		namePostfix: '';
		outDir: '/dev/shm/sanoplasma/Step 1kHz Cross 10-100Hz Offset2 100 30min Up';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Offset' put: '100';
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '1'.
	generator generate.


	generator := self new
		startFreq: 2050;
		endFreq: 899500;
		stepFreq: 500;
		freqRange: -1000;
		programSeconds: 1800;
		crossoverCount: 10;
		crossoverRange: 100;
		namePrefix: 'Fr';
		namePostfix: 'down';
		outDir: '/dev/shm/sanoplasma/Step 1kHz Cross 10-100Hz Offset2 100 30min Down';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Offset' put: '100';
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '1'.
	generator generate.


]

{ #category : #history }
SanoPlasmaPresetGenerator class >> dj20180504 [
	"DJ: Up and Down sets.
	- 30 minute duration
	- No wobble
	- Repeat each program 3 times
	- Crossover at 100Hz mark (instead of 50Hz)"
	<script>

	| generator settings |

	generator := self new
		startFreq: 1050;
		endFreq: 899500;
		stepFreq: 500;
		freqRange: 1000;
		crossoverCount: 10;
		crossoverRange: 100;
		programSeconds: 1800;
		namePrefix: 'Fr';
		namePostfix: '';
		outDir: '/dev/shm/sanoplasma/Step 1kHz Cross 10 30min Up X100Hz';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '1'.
	generator generate.


	generator := self new
		startFreq: 2050;
		endFreq: 899500;
		stepFreq: 500;
		freqRange: -1000;
		programSeconds: 1800;
		crossoverCount: 10;
		crossoverRange: 100;
		namePrefix: 'Fr';
		namePostfix: 'down';
		outDir: '/dev/shm/sanoplasma/Step 1kHz Cross 10 30min Down X100Hz';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '1'.
	generator generate.

]

{ #category : #history }
SanoPlasmaPresetGenerator class >> dj20180609 [
	"DJ: Up and Down sets.
	- 1Hz - 1kHz, 100Hz range, 10Hz step
	- 30 minute duration
	- No wobble
	- Repeat each program 3 times
	- Crossover at 50Hz mark
	- Offset 2 0%"
	<script>

	| generator settings |

	generator := self new
		startFreq: 0;
		endFreq: 900;
		stepFreq: 50;
		freqRange: 100;
		crossoverCount: 10;
		crossoverRange: 10;
		programSeconds: 1800;
		namePrefix: 'Fr';
		namePostfix: '';
		outDir: '/dev/shm/sanoplasma/Step 100Hz Cross 10 30min Up';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '1'.
	generator generate.


	generator := self new
		startFreq: 100;
		endFreq: 1000;
		stepFreq: 50;
		freqRange: -100;
		programSeconds: 1800;
		crossoverCount: 10;
		crossoverRange: 10;
		namePrefix: 'Fr';
		namePostfix: 'down';
		outDir: '/dev/shm/sanoplasma/Step 100Hz Cross 10 30min Down';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '1'.
	generator generate.

]

{ #category : #history }
SanoPlasmaPresetGenerator class >> dj20180609b [
	"DJ: Up and Down sets.
	- 1Hz - 1kHz, 100Hz range, 10Hz step
	- 30 minute duration
	- No wobble
	- Repeat each program 1 time
	- Crossover at 50Hz mark
	- Offset 2 100%"
	<script>

	| generator settings |

	generator := self new
		startFreq: 0;
		endFreq: 900;
		stepFreq: 50;
		freqRange: 100;
		crossoverCount: 10;
		crossoverRange: 10;
		programSeconds: 1800;
		namePrefix: 'Fr';
		namePostfix: '';
		outDir: '/dev/shm/sanoplasma/Step 100Hz Cross 10-50 Offset2 100 30min Up';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Offset' put: '100';
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '1'.
	generator generate.


	generator := self new
		startFreq: 100;
		endFreq: 1000;
		stepFreq: 50;
		freqRange: -100;
		programSeconds: 1800;
		crossoverCount: 10;
		crossoverRange: 10;
		namePrefix: 'Fr';
		namePostfix: 'down';
		outDir: '/dev/shm/sanoplasma/Step 100Hz Cross 10-50 Offset2 100 30min Down';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Offset' put: '100';
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '1'.
	generator generate.

]

{ #category : #templates }
SanoPlasmaPresetGenerator class >> preset201712211429 [

	^'"[Preset]"
"PresetName={presetName}"
"Text2=1"
"Text3=1"
"Text4=1"
"Text9=1"
"Text14=1"
"Text10=0"
"Text11=50"
"Text12(0)=300000"
"Text12(1)=510000"
"Text12(2)=300"
"Text12(3)=0"
"Text12(4)=36"
"Text12(5)=36"
"Text12(6)=5"
"Text13(0)="
"Text17={programName}"
"Text20=6"
"Text21=0"
"Text22(0)=-1"
"Text22(1)={freqSum}"
"Text22(2)={out2VoltageMultiplier}"
"Text22(3)=0"
"Text22(4)=0"
"Text22(5)=1"
"Text22(6)=0"
"Text22(7)=0"
"Text22(10)=0"
"Text22(11)=0"
"Text22(12)=0"
"Text25=0"
"Text27=0"
"Text28="
"Text29=0"
"Text31=16"
"Text32=0"
"Text33=16"
"Text37(0)=900000"
"Text37(1)=1"
"Text37(2)=0"
"Text37(3)=0"
"Text41=0"
"Text44(0)=.1"
"Text44(1)=10"
"Text45=1"
"Text7(0)=1"
"Text7(1)=1"
"Text7(2)=1"
"Text7(3)=1"
"Text7(4)=1"
"Text7(5)=8"
"Text7(6)=8"
"Text7(7)=16"
"Text7(8)=16"
"Text7(9)=1"
"Text7(10)=1"
"Text7(11)=0"
"Text7(12)=0"
"Text7(13)=0"
"Text7(14)=0"
"Text7(15)=0"
"Text7(16)=0"
"Text7(17)=0"
"Text7(18)=0"
"Text7(19)=0"
"Text7(20)=0"
"Text7(21)=0"
"Text7(22)=2"
"Text7(23)=2"
"Text7(24)=2"
"Text7(25)=2"
"Text7(26)=2"
"Text7(27)=2"
"Text7(28)=2"
"Text7(29)=2"
"Text7(30)=2"
"Text7(31)=2"
"Text7(32)=2"
"Text7(33)=0"
"Text7(34)=0"
"Text7(35)=0"
"Text7(36)=0"
"Text7(37)=0"
"Text7(38)=0"
"Text7(39)=0"
"Text7(40)=0"
"Text7(41)=0"
"Text7(42)=0"
"Text7(43)=0"
"Text7(44)=1"
"Text7(45)=0"
"Text7(46)=0"
"Combo1=Add F1 to F2"
"Combo2={harmonicWobble}"
"Combo3=Midnight"
"Combo4=Midnight"
"Combo5=Octave"
"Combo6=Do NOT sort frequencies"
"Combo7=Disabled"
"Combo8=Disabled"
"Combo12=Colloidal Silver"
"Combo14=Sine"
"Option1(0)=False"
"Option1(1)=False"
"Option1(2)=False"
"Option5(0)=True"
"Option5(1)=False"
"Option6(0)=True"
"Option6(1)=False"
"Option6(2)=False"
"Option6(3)=True"
"Option6(4)=False"
"Option6(5)=False"
"Option30(0)=False"
"Option30(1)=True"
"Option30(2)=False"
"Option30(3)=False"
"Option30(4)=False"
"Option30(5)=False"
"Option30(6)=False"
"Option30(7)=False"
"Option30(8)=False"
"Option30(9)=False"
"Option30(10)=False"
"Option40(0)=False"
"Option40(1)=True"
"Option40(2)=False"
"Option40(3)=False"
"Option40(4)=False"
"Option40(5)=False"
"Option40(6)=False"
"Option40(7)=False"
"Option40(8)=False"
"Option40(9)=False"
"Option40(10)=False"
"Option40(11)=False"
"Option40(12)=False"
"Check2=0"
"Check3=0"
"Check4(0)=0"
"Check4(1)=0"
"Check4(2)=1"
"Check6(0)=0"
"Check6(1)=0"
"Check6(2)=1"
"Check6(3)=0"
"Check8(0)=1"
"Check8(1)=1"
"Check8(2)=0"
"Check8(3)=0"
"Check8(4)=0"
"Check8(5)=0"
"Check8(6)=0"
"Check8(7)=0"
"Check8(8)=0"
"Check8(9)=0"
"Check8(10)=0"
"Check8(11)=0"
"Check8(12)=0"
"Check8(13)=0"
"Check8(14)=1"
"Check9(0)=0"
"Check9(1)=0"
"Check12(0)=0"
"Check12(1)=0"
"Check12(2)=0"
"List2={programName} (CUST)"
"List4={fromFrequency}-{toFrequency}={programSeconds}"
"List5={fromFrequency};{toFrequency};{programSeconds};;;;;;;;;;;;;;;;;;"
"[/Preset]"
'
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> crossoverCount [
	^ crossoverCount
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> crossoverCount: anInteger [
	"Set the number of crossovers for each chain.
	If not already set, make the crossover range the chain range / crossoverCount"
	crossoverCount := anInteger.
	crossoverRange ifNil: [ 
		freqRange ifNil: 
			[ self error: 'Frequency range must be set before crossoverCount' ].
		self crossoverRange: (freqRange / crossoverCount) rounded ]
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> crossoverRange [
	^ crossoverRange
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> crossoverRange: anObject [
	crossoverRange := anObject
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> endFreq [
	^ endFreq
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> endFreq: anObject [
	endFreq := anObject
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> filenameAt: freq [
	"Answer the file name used for the specified frequency"

	^String streamContents: [ :fstream |
		fstream << (self programNameAt: freq).
		namePostfix ifNotEmpty: [ 
			fstream
				<< ' ';
				<< namePostfix ].
		fstream
			<< '.txt' ].

]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> freqRange [
	^ freqRange
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> freqRange: anInteger [

	freqRange := anInteger.
	crossoverCount ifNil: 
		[ self crossoverCount: 1 ]
]

{ #category : #actions }
SanoPlasmaPresetGenerator >> generate [
	"Generate the custom.csv file and associated presets in the specified directory"

	| customCSV |

	customCSV := outDir / 'custom.csv'.
	customCSV writeStreamDo: [ :customCsvStream |
		startFreq to: endFreq by: stepFreq do: [ :freq |
			self writeProgramAt: freq to: customCsvStream.
			self writeChainAt: freq. ] ].
]

{ #category : #initialize }
SanoPlasmaPresetGenerator >> initialize [

	super initialize.
	programSeconds := 1800.
	namePrefix := 'Fr'.
	namePostfix := ''.
	settings := SanoPlasmaSettings new 
						at: 'Harmonic Wobble' put: 'None';
						at: 'Out 2 Voltage Multiplier' put: '2';
						yourself.

]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> namePostfix [
	^ namePostfix
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> namePostfix: anObject [
	namePostfix := anObject
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> namePrefix [
	^ namePrefix
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> namePrefix: anObject [
	namePrefix := anObject
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> outDir [
	^ outDir
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> outDir: aDirectory [

	outDir := aDirectory asFileReference.
	outDir isDirectory ifFalse: [ 
		outDir parent isDirectory ifFalse: 
			[self error: 'outDir parent must exist'].
		outDir ensureCreateDirectory ].
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> presetNameFrom: startFrequency to: endFrequency [
	"Generate the program name from the frequency in the form:
			<namePrefix> <startFrequency>-<endFrequency>
	frequency is assumed to be less than 1 million"
	^String streamContents: [ :stream | | freqString |
		"Put the prefix"
		stream
			<< namePrefix;
			<< ' '.

		"Next the startFreq.
		If possible, represent as an integer number of kHz, otherwise as decimal"
		freqString := startFrequency printPaddedWith: $0 to: 6.
		stream
			<< (freqString copyFrom: 1 to: 3).
		(freqString endsWith: '000') ifFalse: [ 
			stream
				<< '.';
				<< (freqString copyFrom: 4 to: 6) ].

		stream << '-'.

		"Next the endFreq.
		If possible, represent as an integer number of kHz, otherwise as decimal"
		freqString := endFrequency printPaddedWith: $0 to: 6.
		stream
			<< (freqString copyFrom: 1 to: 3).
		(freqString endsWith: '000') ifFalse: [ 
			stream
				<< '.';
				<< (freqString copyFrom: 4 to: 6) ] ].

]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> programNameAt: frequency [
	"Generate the program name from the frequency in the form:
			<namePrefix> <startFreq>-<endFreq>
	frequency is assumed to be less than 1 million"
	^String streamContents: [ :stream | | freqString |
		"Put the prefix"
		stream
			<< namePrefix;
			<< ' '.

		"Next the startFreq in kHz.
		Always include the decimal place otherwise the ascii file ordering comes out unexpectedly"
		freqString := frequency printPaddedWith: $0 to: 6.
		stream
			<< (freqString copyFrom: 1 to: 3);
			<< '.';
			<< (freqString copyFrom: 4 to: 6).

		stream << '-'.

		"Next the endFreq."
		freqString := (frequency + freqRange) printPaddedWith: $0 to: 6.
		stream
			<< (freqString copyFrom: 1 to: 3);
			<< '.';
			<< (freqString copyFrom: 4 to: 6) ].

]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> programSeconds [
	^ programSeconds
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> programSeconds: anObject [
	programSeconds := anObject
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> settings [
	^ settings
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> settings: anObject [
	settings := anObject
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> startFreq [
	^ startFreq
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> startFreq: anObject [
	startFreq := anObject
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> stepFreq [
	^ stepFreq
]

{ #category : #accessing }
SanoPlasmaPresetGenerator >> stepFreq: anObject [
	stepFreq := anObject
]

{ #category : #private }
SanoPlasmaPresetGenerator >> writeChainAt: freq [
	"Write the preset file for the supplied frequency creating the configured number of crossovers"

	| chainName presetName fileName fileReference bStream cStream subDir chain preset program frequencyRange fromFreq toFreq signedRange |

	chainName := self programNameAt: freq.
	fileName := self filenameAt: freq.
	subDir := outDir / ('Step ', (freq printPaddedWith: $0 to: 6) first asString, '00').
	subDir ensureCreateDirectory.
	fileReference := subDir / fileName.

	settings	at: 'Program Name' put: chainName.
	chain := SanoPlasmaChain new
					name: chainName;
					yourself.
	signedRange := freqRange copySignTo: crossoverRange.
	1 to: crossoverCount do: [ :i |
		fromFreq := freq + (freqRange * (i - 1) / crossoverCount) rounded.
		toFreq := fromFreq + signedRange.
		fromFreq = 0 ifTrue: [ fromFreq := 1 ].
		toFreq = 0 ifTrue: [ toFreq := 1 ].
		presetName := self presetNameFrom: fromFreq to: toFreq.
		frequencyRange := SanoPlasmaFrequencyRange new 
								fromFrequency: fromFreq;
								toFrequency: toFreq;
								dwell: (programSeconds / crossoverCount) rounded;
								yourself.
		program := SanoPlasmaProgram new 
						name: presetName;
						dwell: (programSeconds / crossoverCount) rounded;
						addFrequency: frequencyRange;
						yourself.
		preset := SanoPlasmaPreset new 
					name: presetName;
					add: program;
					settings: settings;
					yourself.
		chain add: preset ].

	bStream := (File named: fileReference fullName) writeStream.
	cStream := (ZnNewLineWriterStream 
						on: (ZnCharacterWriteStream on: bStream encoding: 'utf8'))
							forCrLf.
	[ chain writeOn: cStream ]
		ensure: [ cStream close ].

]

{ #category : #private }
SanoPlasmaPresetGenerator >> writeProgramAt: freq to: customCsvStream [
	"Add an entry to the supplied CSV stream"

	| fromFreq toFreq |

	fromFreq := freq.
	fromFreq = 0 ifTrue: [ fromFreq := 1 ].
	toFreq := freq + freqRange.
	toFreq = 0 ifTrue: [ toFreq := 1 ].
	customCsvStream 
		nextPut: $";
		<< (self programNameAt: freq);
		<< '",CUST,,"","';
		<< fromFreq asString;
		<< '-';
		<< toFreq asString;
		<< '",,,';
		<< programSeconds asString;
		crlf.

]
