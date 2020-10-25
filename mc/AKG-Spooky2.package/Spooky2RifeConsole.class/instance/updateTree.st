api
updateTree

	self removeChildren.

	self 
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ].

	self controlPanels.
	self generatorPlot.