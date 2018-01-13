private
loadPrograms

	| newPrograms csv |

	fileName readStreamDo: [ :stream |
		csv := NeoCSVReader on: stream.
		newPrograms := Array streamContents: [ :arrayStream |
			csv do: [ :record |
				arrayStream nextPut: (SanoPlasmaProgram fromCollection: record) ] ] ].
	^newPrograms