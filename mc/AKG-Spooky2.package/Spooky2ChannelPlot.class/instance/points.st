accessing
points
	"Answer the collection of points to be plotted"

	^ (1 to: self xPointCount) collect: [ :x |
		x @ ((programme value: x) + offset) ].
