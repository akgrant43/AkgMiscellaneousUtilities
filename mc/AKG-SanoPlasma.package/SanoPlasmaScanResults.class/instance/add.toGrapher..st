private - inspecting
add: scanData toGrapher: grapher
	"Add the supplied scanData to the supplied gapher, setting the labels and offsets as required"

	| frequencies values dataset minFreq maxFreq minValue maxValue averageValue |

	frequencies := scanData columnAt: 2.
	values := scanData columnAt: 3.
	minFreq := frequencies min.
	maxFreq := frequencies max.
	minValue := values min.
	maxValue := values max.
	averageValue := values average.

	"Add the data"
	dataset := RTData new.
	dataset
		noDot;
		points: scanData;
		x: [ :ds | ds second - minFreq ];
		y: [ :ds | ds third - minValue ];
		connectColor: Color blue.
	grapher add: dataset.
	
	"Add a zero line"
"	dataset := RTData new.
	dataset
		noDot;
		points: { { minFreq. 0. }. { maxFreq. 0. }};
		x: [ :ds | ds first - minFreq ];
		y: [ :ds | ds second - minValue ];
		connectColor: Color green.
	grapher add: dataset."

	"Add the average line"
	dataset := RTData new.
	dataset
		noDot;
		points: { { minFreq. averageValue. }. { maxFreq. averageValue. }};
		x: [ :ds | ds first - minFreq ];
		y: [ :ds | ds second - minValue ];
		connectColor: Color gray.
	grapher add: dataset.

	grapher axisX labelConversion: [ :value | value + minFreq ].
	grapher axisY labelConversion: [ :value | (value + minValue) printShowingDecimalPlaces: 1 ].
	^grapher