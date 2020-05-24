initialization
initializeWidgets 

	name := self newTextInput.
	nameLabel := self newLabel label: 'Name:'.
	start := self newButton label: 'Start'.
	stop := self newButton label: 'Stop'.
	pause := self newButton label: 'Pause'.
	c1Function := self newText.
	c2Function := self newText.
	c1Freq := self newLabel.
	c2Freq := self newLabel.
	c1FreqLabel := self newLabel label: 'Channel 1:'.
	c2FreqLabel := self newLabel label: 'Channel 2:'.
	runTime := self newTextInput.
	runTimeLabel := self newLabel label: 'Run Time (min.):'.
	time := self newLabel.
	timeLabel := self newLabel label: 'Time:'.

	self focusOrder 
		add: name;
		add: c1Function;
		add: c2Function;
		add: runTime.