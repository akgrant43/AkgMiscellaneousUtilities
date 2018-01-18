mappings
nameToKeyMap
	"Map the human readable names to the SanoPlasma key"

	^NameKeyMap ifNil: [ NameKeyMap := {
		'Program Name' -> 'Text17'.
		#out1FreqLimitMin -> 'Text37(1)'.
		#out1FreqLimitMax -> 'Text37(0)'.
		} asDictionary ]