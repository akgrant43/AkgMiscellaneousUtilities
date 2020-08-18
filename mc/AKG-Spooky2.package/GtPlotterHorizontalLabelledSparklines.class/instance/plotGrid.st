private
plotGrid
	"Answer an element which is the grid"

	^ BlElement new
			geometry: (BlNormalizedPolyline 
				vertices: { 0@0. 1@0. 1@1. 0@1. 0@0. });
			border: (BlBorder paint: Color black width: 2);
			outskirts: BlOutskirts centered;
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ].
