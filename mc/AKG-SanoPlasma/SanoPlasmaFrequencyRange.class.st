Class {
	#name : #SanoPlasmaFrequencyRange,
	#superclass : #SanoPlasmaModel,
	#instVars : [
		'fromFrequency',
		'toFrequency',
		'dwell',
		'waveform',
		'gating'
	],
	#category : 'AKG-SanoPlasma-Model'
}

{ #category : #'instance creation' }
SanoPlasmaFrequencyRange class >> fromString: aString [
	"Create an instance of the receiver from the supplied string in SanoPlasma format"

	| regex match newRange waveform gating |

	regex := '([.\d]+)-?([.\d]+)?=?(\d+)?(W\d)?(G\d)?' asRegex.
	match := regex matches: aString.
	self assert: match description: aString, ' doesn''t parse as frequency range'.
	newRange := self new
		fromFrequency: (regex subexpression: 2) asNumber;
		toFrequency: (regex subexpression: 3) asNumberOrNil;
		dwell: (regex subexpression: 4) asNumberOrNil.
	waveform := regex subexpression: 5.
	waveform ifNotNil: [ 
		newRange waveform: (waveform at: 2) asString asNumber ].
	gating := regex subexpression: 6.
	gating ifNotNil: [ 
		newRange gating: (gating at: 2) asString asNumber ].
	^newRange
]

{ #category : #converting }
SanoPlasmaFrequencyRange >> asString [
	"Conver the receiver to it's SanoPlasma string representation"

	^String streamContents: [ :stream |
		stream << fromFrequency asString.
		toFrequency ifNotNil: [ 
			stream
				<< '-';
				<< toFrequency asString ].
		dwell ifNotNil: [ 
			stream
				<< '=';
				<< dwell asString ].
		waveform ~= 1 ifTrue: [ 
			stream
				<< 'W';
				<< waveform asString ].
		gating ~= 0 ifTrue: [ 
			stream
				<< 'G';
				<< gating asString ] ]
]

{ #category : #converting }
SanoPlasmaFrequencyRange >> asString1 [
	"Don't really understand this format yet (thus the meaningless name)"

	^String streamContents: [ :stream |
		stream
			<< fromFrequency asString;
			<< ';'.
		toFrequency ifNotNil: [ stream << toFrequency asString ].
		stream << ';'.
		dwell ifNotNil: [ stream << dwell asString ].
		stream << ';;;;;;;;;;;;;;;;;;' ]
]

{ #category : #accessing }
SanoPlasmaFrequencyRange >> dwell [
	^ dwell
]

{ #category : #accessing }
SanoPlasmaFrequencyRange >> dwell: anObject [
	dwell := anObject
]

{ #category : #accessing }
SanoPlasmaFrequencyRange >> fromFrequency [
	^ fromFrequency
]

{ #category : #accessing }
SanoPlasmaFrequencyRange >> fromFrequency: anObject [
	fromFrequency := anObject
]

{ #category : #accessing }
SanoPlasmaFrequencyRange >> gating [
	^ gating
]

{ #category : #accessing }
SanoPlasmaFrequencyRange >> gating: anObject [
	gating := anObject
]

{ #category : #initialization }
SanoPlasmaFrequencyRange >> initialize [

	super initialize.
	gating := 0.
	waveform := 1.
]

{ #category : #printing }
SanoPlasmaFrequencyRange >> printOn: aStream [

	super printOn: aStream.
	aStream 
		<< '(''';
		<< self asString;
		<< ''')'
]

{ #category : #accessing }
SanoPlasmaFrequencyRange >> range [

	^toFrequency - fromFrequency
]

{ #category : #accessing }
SanoPlasmaFrequencyRange >> sum [
	"Answer the sum of the fromFrequency and toFrequency.
	This is needed when setting up a crossover preset."

	^fromFrequency + toFrequency
]

{ #category : #accessing }
SanoPlasmaFrequencyRange >> toFrequency [
	^ toFrequency
]

{ #category : #accessing }
SanoPlasmaFrequencyRange >> toFrequency: anObject [
	toFrequency := anObject
]

{ #category : #accessing }
SanoPlasmaFrequencyRange >> waveform [
	^ waveform
]

{ #category : #accessing }
SanoPlasmaFrequencyRange >> waveform: anObject [
	waveform := anObject
]
