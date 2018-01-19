accessing - convenience
output2Voltage
	"Answer the absolute voltage on Output 2"

	^(self at: 'Out 1 Voltage') asNumber * (self at: 'Out 2 Voltage Multiplier') asNumber