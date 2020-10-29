accessing
points
	"Answer the collection of points to be plotted"
	| timeOffset |

	timeOffset := self channelModel timeOffset asSeconds.
	^ (1 to: self xPointCount) collect: [ :x |
		x @ ((programme value: (x + timeOffset)) + offset) ].
