accessing
offset: aNumber
	"Voltage offset: 0 = -100%, 200 = +100%"

	self assert: (aNumber between: 0 and: 200).
	offset := aNumber.