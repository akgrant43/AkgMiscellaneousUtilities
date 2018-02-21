instance creation
fromStream: aStream
	"Answer an instance of the receiver from the supplied stream.
	The leading '[Preset]' is optional."

	| done entry settings |

	done := false.
	settings := Dictionary new.
	[ done ] whileFalse: [ 
		entry := aStream nextLine.
		(entry isNil or: [entry includesSubstring: '[/Preset]'])
			ifTrue: [ done := true ]
			ifFalse: [ self addKeyValue: entry to: settings ] ].
	^self new
		settings: settings;
		yourself.