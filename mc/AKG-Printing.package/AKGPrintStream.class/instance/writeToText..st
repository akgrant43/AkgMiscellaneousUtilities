private
writeToText: aStream
	"Write the supplied stream to textTemporary"

	| buffer |

	self textTemporary ensureDelete.
	self textTemporary writeStreamDo: [ :stream | | znstream |
		znstream := ZnNewLineWriterStream on: stream.
		[ aStream atEnd ] whileFalse: [ 
			buffer := aStream next: 1024.
			buffer isEmpty ifFalse:
				[ znstream nextPutAll: buffer ] ] ]