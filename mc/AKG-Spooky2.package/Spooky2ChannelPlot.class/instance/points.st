accessing
points
	"Answer the collection of points to be plotted"
	| points y min max |

	points := Array new: self xPointCount.
	min := programme startFrequency.
	max := programme endFrequency.
	1 to: self xPointCount do: [ :x |
		y := (programme value: x) + offset.
		points at: x put: x@y ].
	^ points