events
updateModel 
	| timeString |

	timeString := String streamContents: [ :s | rifeModel time printHMSOn: s ].
	time text: (timeString asRopedText fontSize: 20)