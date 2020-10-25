private
controlPanels
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