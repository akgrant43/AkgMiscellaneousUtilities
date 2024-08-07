Extension { #name : #Duration }

{ #category : #'*AKG-Spooky2' }
Duration >> printHMSOn: aStream [
	"Format as per ANSI 5.8.2.16: [-]D:HH:MM:SS[.S]" 	| d h m s n |
	d := self days abs.
	h := self hours abs + (d * 24).
	m := self minutes abs.
 	s := self seconds abs truncated.

	self negative ifTrue: [ aStream nextPut: $- ].
	h < 10 ifTrue: [ aStream nextPut: $0. ].
	h printOn: aStream. aStream nextPut: $:.
	m < 10 ifTrue: [ aStream nextPut: $0. ].
	m printOn: aStream. aStream nextPut: $:.
	s < 10 ifTrue: [ aStream nextPut: $0. ].
	s printOn: aStream.

]
