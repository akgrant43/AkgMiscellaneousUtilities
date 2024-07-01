"
[[[
console := Spooky2RifeConsole new 
	constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ];
	rifeModel: Spooky2RifeModel new;
 	yourself.
BlSpace new
	root: console;
	open.
]]]
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #Spooky2RifeConsole,
	#superclass : #Spooky2RifeElement,
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #'instance creation' }
Spooky2RifeConsole class >> open [
	| console space |

	console := self new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		rifeModel: Spooky2RifeModel new;
		yourself.
	space := BlSpace new.
	space root addChild: console.
	space show.
	^ console rifeModel
]

{ #category : #private }
Spooky2RifeConsole >> contactsPanel [

	^ Spooky2RifeChannelElement new 
		rifeModel: rifeModel channelModels second; 
		configure
]

{ #category : #private }
Spooky2RifeConsole >> controlPanels [
	| panels |

	panels := BlElement new.
	panels 
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ].

	panels
		addChild: self generatorPanel;
		addChild: self plasmaPanel;
		addChild: self contactsPanel.

	self addChild: panels.
]

{ #category : #private }
Spooky2RifeConsole >> generatorPanel [

	^ Spooky2RifeModelElement new 
		rifeModel: rifeModel; 
		configure
]

{ #category : #private }
Spooky2RifeConsole >> generatorPlot [

	self addChild: (Spooky2GeneratorPlot new rifeModel: rifeModel) create
]

{ #category : #private }
Spooky2RifeConsole >> plasmaPanel [

	^ Spooky2RifeChannelElement new 
		rifeModel: rifeModel channelModels first; 
		configure
]

{ #category : #accessing }
Spooky2RifeConsole >> rifeModel: aRifeModel [

	super rifeModel: aRifeModel.
	self updateTree.
]

{ #category : #api }
Spooky2RifeConsole >> updateTree [

	self removeChildren.

	self 
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ].

	self controlPanels.
	self generatorPlot.
]
