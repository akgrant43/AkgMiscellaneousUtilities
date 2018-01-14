actions
save
	"Write the receiver back to the database"

	| csv |

	fileName ensureDelete.
	fileName writeStreamDo: [ :stream |
		csv := NeoCSVWriter on: stream.
		csv fieldWriter: #optionalQuoted.
		self programs do: [ :program |
			csv nextPut: program asArray ] ]