accessing
graphIn: aView
	| graph c1Dataset c2Dataset minY |

	graph := RTGrapher new.
	graph view: aView.
	minY := self dataFrame min min.
	c1Dataset := RTData new.
	c1Dataset 
		noDot;
		points: ((self dataFrame columnAt: 1) collect: [ :v | v - minY ]);
		connectColor: Color red;
		label: 'Channel 1'.
	graph add: c1Dataset.
	c2Dataset := RTData new.
	c2Dataset 
		noDot;
		points: ((self dataFrame columnAt: 2) collect: [ :v | v - minY ]);
		connectColor: Color blue;
		label: 'Channel 2'.
	graph add: c2Dataset.
	graph legend right.
	graph axisY labelConversion: [ :v | v + minY ].
	graph build.
	^ aView