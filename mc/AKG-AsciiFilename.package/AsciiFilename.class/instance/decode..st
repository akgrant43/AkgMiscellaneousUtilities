converting
decode: aByteArray
	"Attempt to decode the supplied byte array"

	encoders do: [ :encoder |
		[ ^encoder decodeBytes: aByteArray ] 
			on: Error do: [ nil ] ].
	^ aByteArray asString.