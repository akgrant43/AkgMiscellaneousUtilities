as yet unclassified
updateVoltage
	"Update the receiver's model's voltage"

	"Channel 1 isn't allowed to change it's voltage.
	The field should be read-only, this is a hack"
	rifeModel channelNumber = 1 ifTrue:
		[ ^ self updateModel ].
	rifeModel voltage: voltage dataSource text asString asNumber