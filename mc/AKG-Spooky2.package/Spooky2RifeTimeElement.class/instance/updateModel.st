events
updateModel 
	| timeString colour |

	timeString := rifeModel isStopped
		ifTrue: [ '<not running>' ]
		ifFalse: [ String streamContents: [ :s | rifeModel time printHMSOn: s ] ].
	colour := rifeModel isRunning ifTrue: 
			[ Color fromHexString: #'47d147' ]
		ifFalse: [ rifeModel isHeld ifTrue: 
			[ Color red ]
		ifFalse:
			[ Color black ] ].
	time text: ((timeString asRopedText fontSize: 32) foreground: colour)