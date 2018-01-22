initialization
initializeWidgets

	| out2VMName harmonicWobbleName |

	out2VMName := 'Out 2 Voltage Multiplier'.
	harmonicWobbleName := 'Harmonic Wobble'.

	o2vmLabel := self newLabel label: out2VMName, ':'.
	harmonicWobbleLabel := self newLabel label: harmonicWobbleName, ':'.

	inputOut2VoltageMultiplier := self newTextInput 
		autoAccept: true;
		acceptBlock: [ :text | self settingsAt: out2VMName put: text ];
		yourself.
	harmonicWobbleWidget := self newDropList.
	SanoPlasmaSettings harmonicWobbleChoices do: [ :each |
		harmonicWobbleWidget addItemLabeled: each do: [ self setHarmonicWobble ] ].

	self focusOrder
		add: inputOut2VoltageMultiplier.
