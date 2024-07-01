Class {
	#name : #Spooky2RifeChannelModel,
	#superclass : #Spooky2RifeAbstractModel,
	#instVars : [
		'rifeModel',
		'channelNumber',
		'label',
		'functionString',
		'function',
		'generator',
		'frequency',
		'voltage',
		'random',
		'timeOffset',
		'frequencyOffset'
	],
	#category : 'AKG-Spooky2-Rife-Model'
}

{ #category : #ui }
Spooky2RifeChannelModel >> channelControlFor: aView [
	<gtView>

	^aView explicit 
		title: 'Channel ', channelNumber asString;
		priority: 20;
		stencil: [ Spooky2RifeChannelElement new rifeModel: self; configure ].
]

{ #category : #accessing }
Spooky2RifeChannelModel >> channelNumber [
	^ channelNumber
]

{ #category : #accessing }
Spooky2RifeChannelModel >> channelNumber: aNumber [

	channelNumber := aNumber.
	self functionString: (self defaultFunctionUp: (aNumber = 1)).

]

{ #category : #operating }
Spooky2RifeChannelModel >> close [ 

	generator close.
]

{ #category : #private }
Spooky2RifeChannelModel >> configureGenerator [

	generator
		squareWaveChannel: channelNumber;
		channel: channelNumber amplitude: voltage;
		channel: channelNumber frequency: (self valueAt: 0);
		switchOnChannel: channelNumber.
]

{ #category : #private }
Spooky2RifeChannelModel >> defaultFunctionUp: aBoolean [
	| duration |
	
	duration := #('20' '6') at: self channelNumber.
	^ String streamContents: [ :stream |
		stream 
			<< 'Spooky2RampProgramme new'; cr;
			<< '	startFrequency: 1000;'; cr;
			<< '	endFrequency: 2000;'; cr;
			<< '	duration: ';
			<< duration;
			<< ' minutes;'; cr;
			<< '	up: ';
				print: aBoolean; cr ].
]

{ #category : #accessing }
Spooky2RifeChannelModel >> duration [ 

	^ function duration
]

{ #category : #accessing }
Spooky2RifeChannelModel >> frequency [
	^ frequency
]

{ #category : #accessing }
Spooky2RifeChannelModel >> frequency: anObject [
	frequency := anObject
]

{ #category : #accessing }
Spooky2RifeChannelModel >> frequencyOffset [
	^ frequencyOffset
]

{ #category : #accessing }
Spooky2RifeChannelModel >> frequencyOffset: anObject [
	frequencyOffset := anObject
]

{ #category : #accessing }
Spooky2RifeChannelModel >> function [
	^ function
]

{ #category : #accessing }
Spooky2RifeChannelModel >> functionString [
	^ functionString
]

{ #category : #accessing }
Spooky2RifeChannelModel >> functionString: aString [
	| oldString |

	oldString := functionString.
	functionString := aString.
	function := self compileFunction: aString.
	self announcer announce: (Spooky2ParameterChanged new 
		oldValue: oldString;
		newValue: functionString;
		parameterName: #functionString)
]

{ #category : #accessing }
Spooky2RifeChannelModel >> generator [
	^ generator
]

{ #category : #accessing }
Spooky2RifeChannelModel >> generator: anObject [
	generator := anObject
]

{ #category : #accessing }
Spooky2RifeChannelModel >> generatorChannel [

	^ generator channelAt: channelNumber
]

{ #category : #initialization }
Spooky2RifeChannelModel >> initialize [ 

	super initialize.
	announcer := Announcer new.
	state := #stopped.
	random := Random new.
	voltage := 6.
	timeOffset := Duration zero.
	frequencyOffset := 0.
]

{ #category : #accessing }
Spooky2RifeChannelModel >> label [
	^ label ifNil: [ 'Channel ', channelNumber asString ]
]

{ #category : #accessing }
Spooky2RifeChannelModel >> label: anObject [
	label := anObject
]

{ #category : #accessing }
Spooky2RifeChannelModel >> maxFrequency [ 

	^ function maxFrequency
]

{ #category : #accessing }
Spooky2RifeChannelModel >> minFrequency [ 

	^ function minFrequency
]

{ #category : #actions }
Spooky2RifeChannelModel >> pause [ 

	state = #running ifFalse: [ ^ self ].
	self switchOffChannel.
	super pause.
]

{ #category : #operating }
Spooky2RifeChannelModel >> reset [ 

	timeOffset := Duration zero.
]

{ #category : #accessing }
Spooky2RifeChannelModel >> rifeModel [
	^ rifeModel
]

{ #category : #accessing }
Spooky2RifeChannelModel >> rifeModel: anObject [
	rifeModel := anObject
]

{ #category : #operating }
Spooky2RifeChannelModel >> stepBackward [

	self timeOffset: timeOffset - self stepSize
]

{ #category : #private }
Spooky2RifeChannelModel >> stepDuration: stepDuration [
	| localTime newFrequency |

	localTime := rifeModel time + timeOffset.
	newFrequency := self valueAt: localTime asSeconds.
	(rifeModel isWobbling and: [ channelNumber = 1 ]) ifTrue:
		[ newFrequency := (newFrequency + (50 * (rifeModel wobbleFunction at: Time now asDuration))) rounded ].
	newFrequency = frequency ifFalse:
		[ frequency := newFrequency.
		generator channel: channelNumber frequency: newFrequency].
	voltage = self generatorChannel amplitude ifFalse: 
		[ generator channel: channelNumber amplitude: voltage ].
	announcer announce: Spooky2Step new.
]

{ #category : #operating }
Spooky2RifeChannelModel >> stepForward [

	self timeOffset: timeOffset + self stepSize
]

{ #category : #private }
Spooky2RifeChannelModel >> stepSize [ 

	^ (self duration / 100) rounded seconds
]

{ #category : #private }
Spooky2RifeChannelModel >> stopGenerator [

	generator switchOffChannel: channelNumber.
]

{ #category : #ui }
Spooky2RifeChannelModel >> suggestedColor [
	"Answer a suggested colour for the receiver"

	^ BrGlamorousColors distinctTenStrongColors at: self channelNumber + 1
]

{ #category : #operating }
Spooky2RifeChannelModel >> switchOffChannel [

	generator switchOffChannel: channelNumber
]

{ #category : #operating }
Spooky2RifeChannelModel >> switchOnChannel [

	generator switchOnChannel: channelNumber
]

{ #category : #accessing }
Spooky2RifeChannelModel >> time [ 

	^ rifeModel time + timeOffset
]

{ #category : #accessing }
Spooky2RifeChannelModel >> timeOffset [
	^ timeOffset
]

{ #category : #accessing }
Spooky2RifeChannelModel >> timeOffset: anObject [
	| oldOffset |

	oldOffset := timeOffset.
	timeOffset := anObject.
	self announcer announce: (Spooky2ParameterChanged new 
		oldValue: oldOffset;
		newValue: timeOffset;
		parameterName: #timeOffset)
]

{ #category : #actions }
Spooky2RifeChannelModel >> unpause [ 

	state = #paused ifFalse: [ ^ self ].
	self switchOnChannel.
	super unpause.
]

{ #category : #accessing }
Spooky2RifeChannelModel >> valueAt: time [ 
	"Answer the receiver's frequency in Hz at the supplied time (an integer seconds)"

	^ (function valueAt: time) + frequencyOffset
]

{ #category : #accessing }
Spooky2RifeChannelModel >> voltage [
	^ voltage
]

{ #category : #accessing }
Spooky2RifeChannelModel >> voltage: anObject [
	voltage := anObject
]
