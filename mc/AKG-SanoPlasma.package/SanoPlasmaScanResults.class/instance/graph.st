accessing
graph
	"Answer a Roassal2 graph for the receivers data"

	| scanData frequencies values graph dataset minFreq maxFreq minValue maxValue |

	scanData := self scanData.
	frequencies := scanData columnAt: 2.
	values := scanData columnAt: 3.
	minFreq := frequencies min.
	maxFreq := frequencies max.
	minValue := values min.
	maxValue := values max.

	graph := RTGrapher new.
	dataset := RTData new.
	dataset
		noDot;
		points: scanData;
		x: [ :ds | ds second - minFreq ];
		y: [ :ds | ds third - minValue ];
		connectColor: (Color blue).
	graph add: dataset.
	graph axisX labelConversion: [ :value | value + minFreq ].
	graph axisY labelConversion: [ :value | value + minValue ].
	^graph