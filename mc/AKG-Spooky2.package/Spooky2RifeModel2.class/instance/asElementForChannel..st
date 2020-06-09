ui -private
asElementForChannel: channelNumber
	| element |

	element := BlElement new 
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ].

	element addChild: (BrLabel new 
		constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent. ];
		text: 'Function:';
		look: BrGlamorousLabelLook).

	element addChild: (BrEditorElement new 
		constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 100. ];
		editor: (BrTextEditor new 
			text: (functionStrings at: channelNumber) asRopedText )).

	element addChild: (BrLabel new 
		constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent. ];
		text: 'Wobble:';
		look: BrGlamorousLabelLook).

	element addChild: (BrEditorElement new 
		constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 14. ];
		editor: (BrTextEditor new 
			text: (wobbles at: channelNumber) asString asRopedText )).

	element addChild: (BrLabel new 
		constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent. ];
		text: 'Voltage:';
		look: BrGlamorousLabelLook).

	element addChild: (BrEditorElement new 
		constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 14. ];
		editor: (BrTextEditor new 
			text: (voltages at: channelNumber) asString asRopedText )).

	^ element.