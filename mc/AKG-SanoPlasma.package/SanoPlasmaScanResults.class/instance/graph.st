accessing
graph
	"Answer a Roassal2 graph for the receivers data"

	| scanData frequencies values graph dataset minFreq maxFreq minValue maxValue averageValue |

	scanData := self scanData.
	frequencies := scanData columnAt: 2.
	values := scanData columnAt: 3.
	minFreq := frequencies min.
	maxFreq := frequencies max.
	minValue := values min.
	maxValue := values max.
	averageValue := values average.

	graph := RTGrapher new.
	"Add the data"
	dataset := RTData new.
	dataset
		noDot;
		points: scanData;
		x: [ :ds | ds second - minFreq ];
		y: [ :ds | ds third - minValue ];
		connectColor: Color blue.
	graph add: dataset.
	
	"Add a zero line"
	dataset := RTData new.
	dataset
		noDot;
		points: { { minFreq. 0. }. { maxFreq. 0. }};
		x: [ :ds | ds first - minFreq ];
		y: [ :ds | ds second - minValue ];
		connectColor: Color green.
	graph add: dataset.

	"Add the average line"
	dataset := RTData new.
	dataset
		noDot;
		points: { { minFreq. averageValue. }. { maxFreq. averageValue. }};
		x: [ :ds | ds first - minFreq ];
		y: [ :ds | ds second - minValue ];
		connectColor: Color gray.
	graph add: dataset.

	graph axisX labelConversion: [ :value | value + minFreq ].
	graph axisY labelConversion: [ :value | (value + minValue) printShowingDecimalPlaces: 1 ].
	^graph