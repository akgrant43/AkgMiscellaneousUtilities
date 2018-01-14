accessing
name: aString

	self assert: aString isNotEmpty description: 'Name cannot be empty'.
	name := aString