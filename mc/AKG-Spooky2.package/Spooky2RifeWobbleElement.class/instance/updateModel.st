events
updateModel 
	| wobbleString |

	wobbleString := rifeModel wobble asString.
	wobble dataSource text: wobbleString asRopedText.