accessing
next
	"Answer the next sum"

	| valid x y maxZ z |
	"x / y = z"

	valid := false.
	[ valid ] whileFalse: [ 
		y := (1 to: self maxDivisor) atRandom.
		maxZ := (self maxDividend / y) rounded.
		x := (1 to: maxZ) atRandom * y.
		valid := x <= self maxDividend ].
	^String streamContents: [ :stream |
		stream
			<< x printString;
			<< ' / ';
			<< y printString;
			<< ' =' ]