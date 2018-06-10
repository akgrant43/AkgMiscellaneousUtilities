private
writeToText: aStream
	"Write the supplied stream to textTemporary"

	| buffer |

	self textTemporary ensureDelete.
	self textTemporary writeStreamDo: [ :stream |
		[ aStream atEnd ] whileFalse: [ 
			buffer := aStream next: 1024.
			buffer isEmpty ifFalse:
				[ stream nextPutAll: buffer ] ] ]