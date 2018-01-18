tests
testAsString1

	| range testString |

	testString := '123000-456000=1234'.
	range := SanoPlasmaFrequencyRange fromString: testString.

	self assert: range asString equals: testString.