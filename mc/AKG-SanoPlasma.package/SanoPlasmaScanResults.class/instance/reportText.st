printing
reportText
	"Answer the report string with fixed width font"

	| stream |

	stream := TextStream on: (Text new: 1024).
	self textOn: stream.
	^stream contents