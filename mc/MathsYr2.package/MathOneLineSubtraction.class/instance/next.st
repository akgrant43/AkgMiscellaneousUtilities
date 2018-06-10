accessing
next
	"Answer the next sum"

	| a b x y |

	a := (self minValue to: self maxValue) atRandom.
	b := (self minValue to: self maxValue) atRandom.
	x := a max: b.
	y := a min: b.
	^String streamContents: [ :stream |
		stream
			<< x printString;
			<< ' - ';
			<< y printString;
			<< ' =' ]