hooks - children
onAddedToSceneGraph 

	super onAddedToSceneGraph.
	xValueHolder announcer when: ValueChanged send: #updateMarker to: self.
	self updateMarker.