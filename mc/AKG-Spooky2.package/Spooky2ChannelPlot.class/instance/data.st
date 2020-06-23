accessing
data
	"Answer the data structure used by the sparkle line"

	^ GtPlotterDataGroup new
		values: self points;
		colored: (BrGlamorousColors distinctTenStrongColors at: self channelNumber).
		"sorted: [ :a :b | a x < b x ]"