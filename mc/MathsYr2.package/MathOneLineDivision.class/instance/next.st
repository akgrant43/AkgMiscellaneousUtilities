accessing
next
	"Answer the next sum"

	| valid x y maxZ |
	"x / y = z"

	valid := false.
	[ valid ] whileFalse: [ 
		y := (2 to: self maxDivisor) atRandom.
		maxZ := (self maxDividend / y) rounded.
		x := (2 to: maxZ) atRandom * y.
		valid := x <= self maxDividend and: [ (x/y) >= self minValue ] ].
	^String streamContents: [ :stream |
		stream
			<< x printString;
			<< ' / ';
			<< y printString;
			<< ' =' ]