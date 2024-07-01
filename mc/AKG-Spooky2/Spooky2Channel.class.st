Class {
	#name : #Spooky2Channel,
	#superclass : #Object,
	#instVars : [
		'channel',
		'waveform',
		'frequency',
		'amplitude',
		'offset',
		'dutyCycle',
		'phase',
		'pWaveforms'
	],
	#category : 'AKG-Spooky2-Model'
}

{ #category : #accessing }
Spooky2Channel >> amplitude [
	^ amplitude
]

{ #category : #accessing }
Spooky2Channel >> amplitude: aNumber [

	self assert: (aNumber between: 0 and: 20).
	amplitude := aNumber
]

{ #category : #commands }
Spooky2Channel >> amplitudeCommand [

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (24 + channel);
			print: (amplitude * 100) rounded ]
]

{ #category : #'accessing - wave forms' }
Spooky2Channel >> arbitraryWave: number [
	"Set the channel to arbitrary wave number"

	self assert: (number between: 1 and: 15).
	waveform := 100 + number.
]

{ #category : #accessing }
Spooky2Channel >> channel [
	^ channel
]

{ #category : #accessing }
Spooky2Channel >> channel: aNumber [

	self assert: (aNumber between: 1 and: 2).
	channel := aNumber.
]

{ #category : #accessing }
Spooky2Channel >> dutyCycle [
	^ dutyCycle
]

{ #category : #accessing }
Spooky2Channel >> dutyCycle: aNumber [

	self assert: (aNumber between: 1 and: 100).
	dutyCycle := aNumber
]

{ #category : #commands }
Spooky2Channel >> dutyCycleCommand [

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (28 + channel);
			print: dutyCycle ]
]

{ #category : #accessing }
Spooky2Channel >> frequency [
	^ frequency
]

{ #category : #accessing }
Spooky2Channel >> frequency: anObject [
	frequency := anObject
]

{ #category : #commands }
Spooky2Channel >> frequencyCommand [

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (22 + channel);
			print: (frequency * 100) rounded ]
]

{ #category : #'initialize - release' }
Spooky2Channel >> initialize [ 

	super initialize.
	waveform := 0.
	frequency := 0.
	amplitude := 0.
	offset := 0.
	dutyCycle := 0.
	phase := 0.
	pWaveforms := Array new: 15.
]

{ #category : #commands }
Spooky2Channel >> offCommand [

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (60 + channel);
			<< '0' ]
]

{ #category : #accessing }
Spooky2Channel >> offset [
	^ offset
]

{ #category : #accessing }
Spooky2Channel >> offset: aNumber [
	"Voltage offset: 0 = -100%, 200 = +100%"

	self assert: (aNumber between: 0 and: 200).
	offset := aNumber.
]

{ #category : #commands }
Spooky2Channel >> offsetCommand [

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (26 + channel);
			print: offset ]
]

{ #category : #commands }
Spooky2Channel >> onCommand [

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (60 + channel);
			<< '1' ]
]

{ #category : #accessing }
Spooky2Channel >> pWaveform: aNumber values: anArray [

	self assert: (aNumber between: 1 and: 15).
	self assert: anArray size = 1024.
	self assert: (anArray allSatisfy: [ :each | each between: 0 and: 1023 ]).

	pWaveforms at: aNumber put: anArray.
]

{ #category : #commands }
Spooky2Channel >> pWaveformCommand: aNumber [
	| commandString |

	self assert: (aNumber between: 1 and: 15).
	commandString := String streamContents: [ :stream |
		stream 
			<< ':a';
			<< (aNumber printPaddedWith: $0 to: 2).
		(pWaveforms at: aNumber)
			do: [ :value | stream print: value ]
			separatedBy: [ stream nextPut: $, ] ].
	^ commandString.
]

{ #category : #accessing }
Spooky2Channel >> phase [
	^ phase
]

{ #category : #accessing }
Spooky2Channel >> phase: aNumber [

	self assert: (aNumber between: 0 and: 359).
	phase := aNumber
]

{ #category : #commands }
Spooky2Channel >> phaseCommand [

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (30 + channel);
			print: phase ]
]

{ #category : #'accessing - wave forms' }
Spooky2Channel >> rampDown [
	| values |

	values := Array new: 1024.
	1 to: 1023 do: [ :i |
		values at: i put: 1023-i ].
	values at: 1024 put: 1022.
	self pWaveform: 2 values: values.
	self arbitraryWave: 2.
]

{ #category : #'accessing - wave forms' }
Spooky2Channel >> rampUp [
	| values |

	values := Array new: 1024.
	1 to: 1023 do: [ :i |
		values at: i put: i-1 ].
	values at: 1024 put: 0.
	self pWaveform: 1 values: values.
	self arbitraryWave: 1.
]

{ #category : #'accessing - wave forms' }
Spooky2Channel >> sineWave [
	"Set the channel to square wave"

	waveform := 0
]

{ #category : #'accessing - wave forms' }
Spooky2Channel >> squareWave [
	"Set the channel to square wave"

	waveform := 1
]

{ #category : #'accessing - wave forms' }
Spooky2Channel >> triangleWave [
	"Set the channel to triangle wave"

	waveform := 2
]

{ #category : #accessing }
Spooky2Channel >> waveform [
	^ waveform
]

{ #category : #accessing }
Spooky2Channel >> waveform: anObject [
	waveform := anObject
]

{ #category : #commands }
Spooky2Channel >> waveformCommand [
	"Answer the command that will set the generator to the selected waveform"

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (20 + channel);
			print: waveform ]
]
