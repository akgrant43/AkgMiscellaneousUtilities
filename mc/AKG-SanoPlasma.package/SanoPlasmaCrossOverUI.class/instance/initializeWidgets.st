initialization
initializeWidgets

	labelCrossoverFreq := self newLabel label: 'Crossover Freq. (kHz):'.
	labelRange := self newLabel label: 'Range (Hz):'.
	labelTime := self newLabel label: 'Time (min):'.
	labelName := self newLabel label: 'Name:'.
	labelLocation := self newLabel label: 'Location:'.

	inputCrossoverFreq := self newTextInput 
		text: (self defaultAt: #CrossoverFreq ifAbsent: [ 0 ]);
		autoAccept: true;
		acceptBlock: [ :text | self updateSummary ];
		yourself.
	inputRange := self newTextInput 
		text: (self defaultAt: #Range ifAbsent: [ 500 ]);
		autoAccept: true;
		acceptBlock: [ :text | self updateSummary ];
		yourself.
	inputTime := self newTextInput 
		text: (self defaultAt: #Time ifAbsent: [ 15 ]);
		autoAccept: true;
		acceptBlock: [ :text | self updateSummary ];
		yourself.
	inputName := self newTextInput
		ghostText: 'Preset & Program Name';
		autoAccept: true;
		acceptBlock: [ :text | self updateSummary ];
		yourself.
	inputLocation := self newTextInput 
		text: (self defaultAt: #Location ifAbsent: ['FlexX' ]);
		autoAccept: true;
		acceptBlock: [ :text | self updateSummary ];
		yourself.
	summaryText := self newText.
	createButton := self newButton
		label: 'Create';
		action: [ self save ];
		yourself.

	self focusOrder
		add: inputCrossoverFreq;
		add: inputRange;
		add: inputTime;
		add: inputName;
		add: inputLocation;
		add: createButton.
	self updateSummary.