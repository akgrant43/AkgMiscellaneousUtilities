*AKG-AST-Extensions
testcheckForCoverage	
	"Tests for old semantics of Number>>readFrom:"
	
	self should: [(NumberParser parse: '.') = 0 ] raise: Error.
	self assert: (NumberParser parse: '0.0') asNumber equals: 0.
	self assert: (NumberParser parse: '0.1') asNumber equals: 0.1.
	self assert: (NumberParser parse: '1.1') asNumber equals: 1.1.
	self assert: (NumberParser parse: '-1') asNumber equals: -1.