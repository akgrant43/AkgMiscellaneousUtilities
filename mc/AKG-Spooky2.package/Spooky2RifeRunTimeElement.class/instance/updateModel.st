events
updateModel 
	| wobbleString |

	wobbleString := rifeModel wobble asString.
	runTime dataSource text: wobbleString asRopedText.