initialization
initializePresenter 

	start action: [ self startGenerator ].
	stop action: [ self stopGenerator ].
	pause action: [ self pauseGenerator ].

	saveButton action: [ self save ].
	loadButton action: [ self load ].