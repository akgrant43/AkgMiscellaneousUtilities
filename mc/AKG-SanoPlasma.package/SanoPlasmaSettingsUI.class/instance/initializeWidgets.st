initialization
initializeWidgets

	| out2VMName harmonicWobbleName repeatChainName repeatProgramName |

	out2VMName := 'Out 2 Voltage Multiplier'.
	harmonicWobbleName := 'Harmonic Wobble'.
	repeatChainName := 'Repeat Chain'.
	repeatProgramName := 'Repeat each program'.

	o2vmLabel := self newLabel label: out2VMName, ':'.
	harmonicWobbleLabel := self newLabel label: harmonicWobbleName, ':'.
	repeatChainLabel := self newLabel label: repeatChainName, ':'.
	repeatProgramLabel := self newLabel label: repeatProgramName, ':'.

	inputOut2VoltageMultiplier := self newTextInput 
		autoAccept: true;
		acceptBlock: [ :text | self settingsAt: out2VMName put: text ];
		yourself.
	repeatChainWidget := self newTextInput 
		autoAccept: true;
		acceptBlock: [ :text | self settingsAt: repeatChainName put: text ];
		yourself.
	repeatProgramWidget := self newTextInput 
		autoAccept: true;
		acceptBlock: [ :text | self settingsAt: repeatProgramName put: text ];
		yourself.
	harmonicWobbleWidget := self newDropList.
	SanoPlasmaSettings harmonicWobbleChoices do: [ :each |
		harmonicWobbleWidget addItemLabeled: each do: [ self setHarmonicWobble ] ].

	self focusOrder
		add: inputOut2VoltageMultiplier.
