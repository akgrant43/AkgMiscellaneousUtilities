accessing
next
	"Answer the next sum"

	| valid x y |

	valid := false.
	[ valid ] whileFalse: [ 
		x := (self minValue to: self maxValue) atRandom.
		y := (self minValue to: self maxValue) atRandom.
		valid := (x + y) <= self maxSum ].
	^String streamContents: [ :stream |
		stream
			<< x printString;
			<< ' + ';
			<< y printString;
			<< ' =' ]