events
updateModel 
	| timeString |

	timeString := rifeModel isStopped
		ifTrue: [ '<not running>' ]
		ifFalse: [ String streamContents: [ :s | rifeModel time printHMSOn: s ] ].
	time text: (timeString asRopedText fontSize: 20)