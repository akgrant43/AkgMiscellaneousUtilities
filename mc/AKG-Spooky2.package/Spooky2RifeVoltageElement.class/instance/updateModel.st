events
updateModel 
	| voltageString |

	voltageString := rifeModel voltage asString.
	voltage dataSource text: voltageString asRopedText.