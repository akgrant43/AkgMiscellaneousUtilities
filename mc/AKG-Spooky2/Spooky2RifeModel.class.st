Class {
	#name : #Spooky2RifeModel,
	#superclass : #Spooky2RifeAbstractModel,
	#instVars : [
		'channelModels',
		'generator',
		'runTime',
		'process',
		'lastStepTime',
		'time',
		'isWobbling',
		'wobbleFunction'
	],
	#category : 'AKG-Spooky2-Rife-Model'
}

{ #category : #operating }
Spooky2RifeModel >> adjustTime: aDuration [
	"Adjust the receiver's time and its channels by the supplied duration"

	time := time + aDuration.

]

{ #category : #ui }
Spooky2RifeModel >> channel1ControlFor: aView [
	<gtView>

	^ aView forward 
		title: self channelModels first label;
		priority: 20;
		object: [ self channelModels first ];
		view: #channelControlFor:.
]

{ #category : #ui }
Spooky2RifeModel >> channel2ControlFor: aView [
	<gtView>

	^ aView forward 
		title: self channelModels second label;
		priority: 30;
		object: [ self channelModels second ];
		view: #channelControlFor:.
]

{ #category : #accessing }
Spooky2RifeModel >> channelModels [
	^ channelModels
]

{ #category : #operating }
Spooky2RifeModel >> close [ 

	generator close.
]

{ #category : #private }
Spooky2RifeModel >> configureGenerator [

	channelModels do: #configureGenerator
]

{ #category : #accessing }
Spooky2RifeModel >> generator [
	^ generator
]

{ #category : #accessing }
Spooky2RifeModel >> generator: aSignalGenerator [

	generator := aSignalGenerator.
	channelModels do: [ :channel | channel generator: aSignalGenerator ]
]

{ #category : #ui }
Spooky2RifeModel >> generatorControlFor: aView [
	<gtView>

	^aView explicit 
		title: 'Generator';
		priority: 10;
		stencil: [ Spooky2RifeModelElement new rifeModel: self; configure ]
]

{ #category : #operating }
Spooky2RifeModel >> hold [ 

	channelModels do: #hold.
	super hold.
]

{ #category : #initialization }
Spooky2RifeModel >> initialize [ 

	super initialize.
	generator := Spooky2SignalGenerator findPort
		ifNil: [ Spooky2SignalGeneratorSimulator new ]
		ifNotNil: [ Spooky2SignalGenerator new ].
	generator connect.
	state := #stopped.
	channelModels := Array new: 2.
	channelModels at: 1 put: 
		(Spooky2RifeChannelModel new
			rifeModel: self;
			generator: generator;
			channelNumber: 1;
			label: 'Plasma').
	channelModels first
		when: Spooky2ParameterChanged
		do: [ :announcement | self announce: announcement ].
	channelModels at: 2 put: 
		(Spooky2RifeChannelModel new
			rifeModel: self;
			generator: generator;
			channelNumber: 2;
			label: 'Contacts').
	channelModels second
		when: Spooky2ParameterChanged
		do: [ :announcement | self announce: announcement ].
	runTime := 60 minutes.
	isWobbling := false.
	wobbleFunction := Spooky2TriangleWave new period: 30 seconds.
]

{ #category : #testing }
Spooky2RifeModel >> isWobbling [

	^ isWobbling 
]

{ #category : #accessing }
Spooky2RifeModel >> lastStepTime [
	^ lastStepTime
]

{ #category : #accessing }
Spooky2RifeModel >> lastStepTime: anObject [
	lastStepTime := anObject
]

{ #category : #accessing }
Spooky2RifeModel >> maxFrequency [

	^ (channelModels collect: [ :each | each maxFrequency ]) max
]

{ #category : #accessing }
Spooky2RifeModel >> minFrequency [

	^ (channelModels collect: [ :each | each minFrequency ]) min
]

{ #category : #actions }
Spooky2RifeModel >> pause [
	"Toggle the paused state of the programme"

	state = #running ifFalse: [ ^ self error: 'Attempt to pause while not running' ].
	channelModels do: #pause.
	super pause.

]

{ #category : #ui }
Spooky2RifeModel >> plotFor: aView [
	<gtView>

	^aView explicit 
		title: 'Graph';
		priority: 50;
		stencil: ( Spooky2GeneratorPlot new rifeModel: self )
]

{ #category : #operating }
Spooky2RifeModel >> reset [ 

	time := Duration zero.
	channelModels do: #reset.
]

{ #category : #accessing }
Spooky2RifeModel >> runTime [
	^ runTime
]

{ #category : #accessing }
Spooky2RifeModel >> runTime: anObject [
	| oldRunTime |

	oldRunTime := runTime.
	runTime := anObject.
	self announcer announce: (Spooky2ParameterChanged new 
		oldValue: oldRunTime;
		newValue: runTime;
		parameterName: #runTime)
]

{ #category : #operating }
Spooky2RifeModel >> start [ 

	process ifNotNil: [ self error: 'Existing process' ].
	state = #stopped ifFalse: [ self error: 'Already running' ].

	self reset.
	lastStepTime := DateAndTime now.
	state := #running.
	channelModels do: #start.
	self configureGenerator.
	process := [ 
		[ state = #stopped ] whileFalse:
			[ self step.
			(Delay forSeconds: 1) wait.
			time > runTime ifTrue: [ self stop ] ].
		self stopGenerator.
		process := nil. ] forkNamed: 'Spooky2 Runner'.

]

{ #category : #operating }
Spooky2RifeModel >> startWobble [

	isWobbling := true
]

{ #category : #operating }
Spooky2RifeModel >> step [ 
	| now stepDuration |

	state = #stopped ifTrue: [ ^self ].
	now := DateAndTime now.
	stepDuration := now - lastStepTime.
	lastStepTime := now.

	self stepDuration: stepDuration.

]

{ #category : #operating }
Spooky2RifeModel >> stepBackward [
	"Step the receiver and its channels backward by stepSize"

	time := time - self stepSize.

]

{ #category : #private }
Spooky2RifeModel >> stepDuration: stepDuration [

	state = #running ifTrue:
		[ time := time + stepDuration ].
	channelModels do: [ :channel |
		channel stepDuration: stepDuration ].
	announcer announce: Spooky2Step new.
]

{ #category : #operating }
Spooky2RifeModel >> stepForward [
	"Step the receiver and its channels forward by stepSize"

	time := time + self stepSize

]

{ #category : #private }
Spooky2RifeModel >> stepSize [
	"Answer the duration to step, currently 1% of the smaller channel duration"

	^ ((channelModels first duration min: channelModels second duration) / 100) rounded seconds.
]

{ #category : #operating }
Spooky2RifeModel >> stop [ 

	channelModels do: #stop.
	super stop.
]

{ #category : #private }
Spooky2RifeModel >> stopGenerator [

	channelModels do: #stopGenerator
]

{ #category : #operating }
Spooky2RifeModel >> stopWobble [

	isWobbling := false
]

{ #category : #accessing }
Spooky2RifeModel >> time [
	^ time
]

{ #category : #accessing }
Spooky2RifeModel >> time: anObject [
	time := anObject
]

{ #category : #operating }
Spooky2RifeModel >> unhold [ 

	channelModels do: #unhold.
	super unhold.
]

{ #category : #actions }
Spooky2RifeModel >> unpause [

	state = #paused ifFalse: [ ^ self error: 'Attempt to unpause while not paused' ].
	channelModels do: #unpause.
	super unpause.

]

{ #category : #accessing }
Spooky2RifeModel >> wobbleFunction [

	^ wobbleFunction
]
