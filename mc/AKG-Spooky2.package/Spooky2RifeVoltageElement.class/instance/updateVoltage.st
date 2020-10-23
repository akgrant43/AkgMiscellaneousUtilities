events
updateVoltage
	"Update the receiver's model's voltage"
	| newVoltage |

	"Ignore any errors and wait for the user to enter something valid"
	"Channel 1 isn't allowed to change it's voltage.
	The field should be read-only, this is a hack"
	[ rifeModel channelNumber = 1 ifTrue:
		[ ^ voltage dataSource text: '6' asRopedText ].
	newVoltage := voltage dataSource text asString asNumber.
	rifeModel voltage: newVoltage ]
			on: Error 
			do: [ ].