accessing
plotStencil: anObject

	plotStencil := anObject.
	self regeneratePlot.
	self rifeModel 
				when: Spooky2ParameterChanged 
				do: [ self regeneratePlot ]