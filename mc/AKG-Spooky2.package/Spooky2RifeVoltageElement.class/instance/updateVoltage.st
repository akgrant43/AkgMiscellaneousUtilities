events
updateVoltage
	"Update the receiver's model's voltage"
	| vString newVoltage |

	vString := voltage dataSource text asString.
	(NumberParser isNumber: vString) ifFalse: 
		[ voltage background: Color red.
		^ self ].
	newVoltage := vString asNumber.
	(newVoltage between: 0 and: 20) ifFalse:
		[ voltage background: Color red.
		^ self ].
	rifeModel voltage: newVoltage.
	voltage background: self inputBackgroundColor.