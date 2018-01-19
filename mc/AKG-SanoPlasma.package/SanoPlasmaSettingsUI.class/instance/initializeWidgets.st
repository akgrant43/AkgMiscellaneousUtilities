initialization
initializeWidgets

	| out2VMName |

	out2VMName := 'Out 2 Voltage Multiplier'.
	o2vmLabel := self newLabel label: out2VMName, ':'.

	inputOut2VoltageMultiplier := self newTextInput 
		autoAccept: true;
		acceptBlock: [ :text | self settingsAt: out2VMName put: text ];
		yourself.

	self focusOrder
		add: inputOut2VoltageMultiplier.
