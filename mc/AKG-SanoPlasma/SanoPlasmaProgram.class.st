Class {
	#name : #SanoPlasmaProgram,
	#superclass : #SanoPlasmaModel,
	#instVars : [
		'name',
		'runningTime',
		'notes',
		'frequencies',
		'organ',
		'illness',
		'dwell'
	],
	#category : 'AKG-SanoPlasma-Model'
}

{ #category : #'instance creation' }
SanoPlasmaProgram class >> fromCollection: aCollection [
	"Answer an instance of the receiver derived from the supplied collection,
	which is a csv record in SanoPlasma custom.csv format"

	^self new 
		name: (aCollection at: 1);
		runningTime: (aCollection at: 3) asNumberOrNil;
		notes: (aCollection at: 4);
		addFrequencies: (aCollection at: 5);
		organ: (aCollection at: 6);
		illness: (aCollection at: 7);
		dwell: (aCollection at: 8) asNumberOrNil;
		yourself.
]

{ #category : #accessing }
SanoPlasmaProgram >> addFrequencies: aString [
	"Add the list of frequency ranges encoded in the supplied string"

	aString ifNil: [ ^self ].
	(',' split: aString) do: [ :range |
		self addFrequency: (SanoPlasmaFrequencyRange fromString: range) ].
]

{ #category : #accessing }
SanoPlasmaProgram >> addFrequency: aFrequencyRange [
	"Add the supplied frequency range to the receiver"

	^frequencies add: aFrequencyRange
]

{ #category : #converting }
SanoPlasmaProgram >> asArray [
	"Answer the receiver as an Array in SanoPlasma format"

	^{
		name.
		'CUST'.
		runningTime.
		notes.
		',' join: (frequencies collect: [ :each | each asString ]).
		organ.
		illness.
		dwell.
	}
]

{ #category : #printing }
SanoPlasmaProgram >> descriptionText [
	"Answer a multi-line description of the receiver"

	^String streamContents: [ :stream |
		stream
			<< 'Name: ';
			<< name asString; cr; cr;
			<< 'Frequencies: '; cr.
		frequencies do: [ :freq |
			stream
				<< '- ';
				<< freq asString; cr ].
		stream
			<< 'Dwell: ';
			<< dwell asString; cr;
			<< 'Notes:'; cr;
			<< notes asString; cr;
			cr; cr;
			<< 'Running Time: ';
			<< runningTime asString; cr;
			<< 'Organ: ';
			<< organ asString; cr;
			<< 'Illness: ';
			<< illness asString; cr ]
]

{ #category : #printing }
SanoPlasmaProgram >> displayString [

	^self name
]

{ #category : #accessing }
SanoPlasmaProgram >> dwell [
	^ dwell
]

{ #category : #accessing }
SanoPlasmaProgram >> dwell: anObject [
	dwell := anObject
]

{ #category : #accessing }
SanoPlasmaProgram >> frequencies [

	^ frequencies
]

{ #category : #inspecting }
SanoPlasmaProgram >> gtInspectIn: composite [
	<gtInspectorPresentationOrder: 2>

	^ composite text
		title: 'Summary';
		format: #asText;
		display: [self descriptionText].
]

{ #category : #accessing }
SanoPlasmaProgram >> illness [
	^ illness
]

{ #category : #accessing }
SanoPlasmaProgram >> illness: anObject [
	illness := anObject
]

{ #category : #initialization }
SanoPlasmaProgram >> initialize [

	super initialize.
	frequencies := OrderedCollection new.
	notes := ''.
]

{ #category : #testing }
SanoPlasmaProgram >> isProgram [
	"Answer a boolean indicating if the receiver is a SanoPlasma Program"

	^true
]

{ #category : #accessing }
SanoPlasmaProgram >> name [
	^ name
]

{ #category : #accessing }
SanoPlasmaProgram >> name: aString [

	name := aString ifEmpty: [ '(unnamed)' ]
]

{ #category : #accessing }
SanoPlasmaProgram >> notes [
	^ notes
]

{ #category : #accessing }
SanoPlasmaProgram >> notes: aString [

	notes := aString ifNil: [ '' ]
]

{ #category : #accessing }
SanoPlasmaProgram >> organ [
	^ organ
]

{ #category : #accessing }
SanoPlasmaProgram >> organ: anObject [
	organ := anObject
]

{ #category : #printing }
SanoPlasmaProgram >> printOn: aStream [

	super printOn: aStream.
	name ifNotNil: [ 
		aStream 
			<< '(';
			<< name asString;
			<< ')' ]
]

{ #category : #accessing }
SanoPlasmaProgram >> runningTime [
	^ runningTime
]

{ #category : #accessing }
SanoPlasmaProgram >> runningTime: anObject [
	runningTime := anObject
]

{ #category : #accessing }
SanoPlasmaProgram >> timeInSeconds [
	"Answer the total time in seconds"

	^frequencies inject: 0 into: [ :sum :freq | sum + 
		(freq dwell ifNil: [dwell]) ]
]
