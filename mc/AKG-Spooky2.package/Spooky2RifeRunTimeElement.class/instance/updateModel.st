events
updateModel 
	| runTimeString |

	runTimeString := (rifeModel runTime asSeconds / 60.0) asString, ' mins.'.
	runTime dataSource text: (runTimeString asRopedText fontSize: 32).