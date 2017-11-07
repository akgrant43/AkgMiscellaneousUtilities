comparing
= anObject
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ fileSize = anObject fileSize
		and: [ hash1 = anObject hash1 and: [ hash2 = anObject hash2 ] ]