accessing
data
	"Answer the data structure used by the sparkle line"

	^ GtPlotterDataGroup new
		values: self points;
		sorted: [ :a :b | a x < b x ].