Class {
	#name : #SanoPlasmaPreset,
	#superclass : #SanoPlasmaModel,
	#instVars : [
		'name',
		'settings',
		'programs'
	],
	#category : 'AKG-SanoPlasma-Model'
}

{ #category : #'instance creation' }
SanoPlasmaPreset class >> fromStream: aStream [
	"Answer a new instance of the receiver parsed from the supplied stream"

	| preset settings |

	settings := SanoPlasmaSettings fromStream: aStream.
	preset := self new 
		settings: settings;
		name: (settings at: 'PresetName' ifAbsent: [ '' ]);
		add: (SanoPlasmaProgram new 
					addFrequencies: (settings at: 'List4' ifAbsent: []);
					name: (settings at: 'Program Name' ifAbsent: ['']);
					yourself);
		yourself.
	^preset
]

{ #category : #templates }
SanoPlasmaPreset class >> template [
	"Answer the template used to write out SanoPlasma presets"

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
"Text22(2)=2"
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
"Text37(0)={out1FreqLimitMax}"
"Text37(1)={out1FreqLimitMin}"
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
"Combo2=+-.02% Feathering"
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
"List4={fromFrequency}-{toFrequency}={timeInSeconds}"
"List5={fromFrequency};{toFrequency};{timeInSeconds};;;;;;;;;;;;;;;;;;"
"[/Preset]"
'
]

{ #category : #adding }
SanoPlasmaPreset >> add: aProgram [

	^programs add: aProgram
]

{ #category : #accessing }
SanoPlasmaPreset >> fileNameIn: aDirectory [
	"Answer the receivers FileReference"

	^aDirectory / (name, '.txt')
]

{ #category : #initialization }
SanoPlasmaPreset >> initialize [

	super initialize.
	programs := OrderedCollection new.
]

{ #category : #accessing }
SanoPlasmaPreset >> name [
	^ name
]

{ #category : #accessing }
SanoPlasmaPreset >> name: anObject [
	name := anObject
]

{ #category : #printing }
SanoPlasmaPreset >> printOn: aStream [

	super printOn: aStream.
	aStream
		<< '(';
		<< name asString;
		<< ')'
]

{ #category : #accessing }
SanoPlasmaPreset >> programs [
	^ programs
]

{ #category : #writing }
SanoPlasmaPreset >> saveIn: aDirectory [
	"Save the receiver in the supplied directory"

	| fileName stream |

	self assert: aDirectory parent isDirectory description: 'Parent directory must exist'.
	aDirectory ensureCreateDirectory.
	fileName := self fileNameIn: aDirectory.

	"MultiByteFileStream seems to have more and more problems..."
	stream := (File named: fileName fullName) writeStream. 
	[ self writeOn: (ZnCrPlatformWriteStream 
							on: (ZnCharacterWriteStream on: stream encoding: 'utf8')
							lineEnd: String crlf) ]
		ensure: [ stream close ].

]

{ #category : #accessing }
SanoPlasmaPreset >> settings [
	^ settings
]

{ #category : #accessing }
SanoPlasmaPreset >> settings: anObject [
	settings := anObject
]

{ #category : #writing }
SanoPlasmaPreset >> writeOn: aStream [
	"Write the receiver on aStream"

	| program frequencyRange |

	self assert: name isNotNil description: 'Preset Name not supplied'.
	self assert: programs size = 1 description: 'Can only save a preset with a single program for now'.
	program := programs first.
	self assert: program frequencies size = 1 description: 'Can only handle a single frequency range'.
	frequencyRange := program frequencies first.

	settings 
		at: 'PresetName' put: self name;
		at: 'Text17' put: program name;
		at: 'Text22(1)' put: frequencyRange sum;
		at: 'List2' put: program name, ' (CUST)';
		at: 'List4' put: frequencyRange asString;
		at: 'List5' put: frequencyRange asString1.

	aStream << '"[Preset]"'; cr.
	settings writeOn: aStream.
	aStream << '"[/Preset]"'; cr.

]
