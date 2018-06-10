private
basename

	^basename ifNil: [ basename := self newTempBasename ]