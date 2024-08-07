Class {
	#name : #SanoPlasmaPresetTests,
	#superclass : #TestCase,
	#category : 'AKG-SanoPlasma-Tests'
}

{ #category : #constants }
SanoPlasmaPresetTests >> template1 [

	^'"[Preset]"
"PresetName=Preset Name"
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
"Text17=Program Names"
"Text20=6"
"Text21=0"
"Text22(0)=-1"
"Text22(1)=579000"
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
"List2=Program Names (CUST)"
"List4=123000-456000=789"
"List5=123000;456000;789;;;;;;;;;;;;;;;;;;"
"[/Preset]"
'
]

{ #category : #tests }
SanoPlasmaPresetTests >> testFromStream [

	| preset program range |

	preset := SanoPlasmaPreset fromStream: self template1 readStream.
	self assert: preset name equals: 'Preset Name'.
	self assert: preset programs size equals: 1.
	program := preset programs first.
	self assert: program frequencies size equals: 1.
	range := program frequencies first.
	self assert: range fromFrequency equals: 123000.
	self assert: range toFrequency equals: 456000.
]

{ #category : #tests }
SanoPlasmaPresetTests >> testWriteOn [

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
]
