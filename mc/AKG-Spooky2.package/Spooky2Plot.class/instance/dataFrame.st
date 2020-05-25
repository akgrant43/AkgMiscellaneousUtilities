accessing
dataFrame
	^ dataFrame ifNil: [ dataFrame := self generateDataFrame ]