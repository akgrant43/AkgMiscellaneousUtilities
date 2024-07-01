Class {
	#name : #Spooky2RifeVoltageElement,
	#superclass : #Spooky2RifeElement,
	#instVars : [
		'voltage'
	],
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #configuration }
Spooky2RifeVoltageElement >> configure [ 

	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 200.
					c vertical fitContent. ];
		text: ('Voltage (V):' asRopedText fontSize: 32)).

	voltage := BrEditorElement new 
		constraintsDo: [ :c |
					c horizontal exact: 100.
					c vertical fitContent. ];
		editor: (BrTextEditor new 
			text: (rifeModel voltage asString asRopedText fontSize: 32)).

	rifeModel channelNumber = 1 ifTrue: 
		[ voltage editor beReadOnlyWithoutSelection ]
	ifFalse:
		[ voltage
			when: BlKeyUpEvent 
			do: [ :event | self updateVoltage ].
		voltage background: self inputBackgroundColor ].
	self addChild: voltage.
]

{ #category : #events }
Spooky2RifeVoltageElement >> updateParameters [

	super updateParameters.
	self updateVoltage.
]

{ #category : #events }
Spooky2RifeVoltageElement >> updateVoltage [
	"Update the receiver's model's voltage"
	| vString newVoltage |

	vString := voltage dataSource text asString.
	(NumberParser isNumber: vString) ifFalse: 
		[ voltage background: Color red.
		^ self ].
	newVoltage := vString asNumber.
	(newVoltage between: 0 and: 20) ifFalse:
		[ voltage background: Color red.
		^ self ].
	rifeModel voltage: newVoltage.
	voltage background: self inputBackgroundColor.
]
