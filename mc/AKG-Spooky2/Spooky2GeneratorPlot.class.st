"
Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables
	channel1Plot:		<Spooky2ChannelPlot>
	channel2Plot:		<Spooky2ChannelPlot>
	rifeModel:			<Spooky2RifeModel>
	timeProportionHolder:		<NewValueHolder> value: (aNumber between: 0 and: 1)


!!!Implementation Points
"
Class {
	#name : #Spooky2GeneratorPlot,
	#superclass : #BrStencil,
	#instVars : [
		'rifeModel',
		'channel1Plot',
		'channel2Plot',
		'timeProportionHolder'
	],
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #accessing }
Spooky2GeneratorPlot >> channel1Plot [
	^ channel1Plot ifNil: 
		[ channel1Plot := Spooky2ChannelPlot new 
			programme: rifeModel channelModels first function;
			rifeModel: rifeModel;
			channelNumber: 1 ]
]

{ #category : #accessing }
Spooky2GeneratorPlot >> channel1Plot: anObject [
	channel1Plot := anObject
]

{ #category : #accessing }
Spooky2GeneratorPlot >> channel2Plot [
	^ channel2Plot ifNil: 
		[ channel2Plot := Spooky2ChannelPlot new 
			programme: rifeModel channelModels second function;
			rifeModel: rifeModel;
			channelNumber: 2 ]
]

{ #category : #accessing }
Spooky2GeneratorPlot >> channel2Plot: anObject [
	channel2Plot := anObject
]

{ #category : #accessing }
Spooky2GeneratorPlot >> create [ 

	^ Spooky2TimePlotElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		plotStencil: self;
		yourself.

]

{ #category : #initialization }
Spooky2GeneratorPlot >> initialize [

	super initialize.
	timeProportionHolder := NewValueHolder new.
]

{ #category : #accessing }
Spooky2GeneratorPlot >> programme1: aSpooky2Programme [

	channel1Plot := Spooky2ChannelPlot new 
		programme: aSpooky2Programme
]

{ #category : #accessing }
Spooky2GeneratorPlot >> programme2: aSpooky2Programme [

	channel2Plot := Spooky2ChannelPlot new 
		programme: aSpooky2Programme
]

{ #category : #initialization }
Spooky2GeneratorPlot >> reset [ 

	channel1Plot := nil.
	channel2Plot := nil.
]

{ #category : #accessing }
Spooky2GeneratorPlot >> rifeModel [
	^ rifeModel
]

{ #category : #accessing }
Spooky2GeneratorPlot >> rifeModel: aRifeModel [

	rifeModel ifNotNil: 
		[ rifeModel announcer unsubscribe: self ].
	rifeModel := aRifeModel.
	rifeModel announcer 
			when: Spooky2Step 
			do: [ timeProportionHolder value: (rifeModel time asSeconds / rifeModel runTime asSeconds) ]
			for: self
]

{ #category : #accessing }
Spooky2GeneratorPlot >> runTime [

	^ rifeModel runTime
]

{ #category : #accessing }
Spooky2GeneratorPlot >> timeProportionHolder [

	^ timeProportionHolder
]
