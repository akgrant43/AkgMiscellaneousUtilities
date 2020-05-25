initialization
initializeWidgets 

	start := self newButton label: 'Start'.
	stop := self newButton label: 'Stop'.
	pause := self newButton label: 'Pause'.
	c1Function := self newText.
	c2Function := self newText.
	c1FunctionLabel := self newLabel label: 'Channels 1 & 2:'.
	c2FunctionLabel := self newLabel label: 'Channel 2:'.
	c1Freq := self newLabel.
	c2Freq := self newLabel.
	c1FreqLabel := self newLabel label: 'Ch 1 Freq.:'.
	c2FreqLabel := self newLabel label: 'Ch 2 Freq.:'.
	runTime := self newTextInput.
	runTimeLabel := self newLabel label: 'Run Time (min.):'.
	time := self newLabel.
	timeLabel := self newLabel label: 'Time:'.
	wobbleLabel := self newLabel label: 'Wobble:'.
	enableWobble := self newCheckBox label: 'Enable'.
	enableWobble whenChangedDo: [ self setWobble ].
	wobbleAmount := self newTextInput.
	stepBackButton := self newButton label: '<'.
	stepForwardButton := self newButton label: '>'.
	zapperVoltage := self newTextInput.
	zapperVoltage whenTextChanged: [ self setZapperVoltage ].
	zapperVoltageLabel := self newLabel label: 'Zap. V.:'.

	self focusOrder 
		add: c1Function;
		add: c2Function;
		add: runTime;
		add: wobbleAmount;
		add: zapperVoltage.