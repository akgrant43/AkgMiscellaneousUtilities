events
updateParameters
	| wobbleString |

	super updateParameters.
	wobbleString := rifeModel wobble asString.
	wobble dataSource text: wobbleString asRopedText.