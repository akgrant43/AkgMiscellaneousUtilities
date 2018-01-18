accessing
at: keyOrName
	"Answer the setting with the supplied key or name"

		^self at: keyOrName ifAbsent: [ KeyNotFound signalFor: keyOrName in: self ].