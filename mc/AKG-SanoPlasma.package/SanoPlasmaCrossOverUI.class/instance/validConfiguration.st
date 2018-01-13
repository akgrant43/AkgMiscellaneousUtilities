testing
validConfiguration
	"Answer a boolean indicating whether the configuration is valid"

	^self crossoverFrequency isNumber and: [
		self name isNotEmpty and: [ 
		self range isNumber and: [
		self fromFrequency isNumber and: [ 
		self toFrequency isNumber and: [ 
		self crossoverFrequency > 0 and: [ 
		self fromFrequency > 0 and: [ 
		self toFrequency > 0 ]]]]]]]