accessing
data
	"Answer the data structure used by the sparkle line"

	^ GtPlotterDataGroup new
		values: self points;
		colored: self plotColor.
