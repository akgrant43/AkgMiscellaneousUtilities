initialization
initializePresenter 

	start action: [ self startGenerator ].
	stop action: [ self stopGenerator ].
	pause action: [ self pauseGenerator ].

	stepBackButton action: [ self stepBackward ].
	stepForwardButton action: [ self stepForward ].

	plotButton action: [ self plotGraph ].