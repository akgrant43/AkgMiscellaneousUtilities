writing
writeOn: aStream

	self assert: presets isNotEmpty 
		description: 'Error: no presets'.

	presets do: [ :preset | preset writeOn: aStream ]