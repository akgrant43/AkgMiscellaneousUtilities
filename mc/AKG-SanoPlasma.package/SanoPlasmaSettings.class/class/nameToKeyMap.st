mappings
nameToKeyMap
	"Map the human readable names to the SanoPlasma key"

	^NameKeyMap ifNil: [ NameKeyMap := {
		#out1FreqLimitMin -> 'Text37(1)'.
		#out1FreqLimitMax -> 'Text37(0)'.
		} asDictionary ]