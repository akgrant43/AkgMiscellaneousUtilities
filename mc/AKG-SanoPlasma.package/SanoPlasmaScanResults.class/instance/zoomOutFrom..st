private - inspecting
zoomOutFrom: graphData
	"Answer the dataset with twice the range of the selected data set"

	| minFreq maxFreq range centre rows |

	graphData numberOfRows = self scanData numberOfRows ifTrue: [ 
		UIManager default inform: 'Already zoomed out, ignoring'.
		^nil ].
	minFreq := (graphData at: 1) at: 2.
	maxFreq := (graphData at: graphData numberOfRows) at: 2.
	range := maxFreq - minFreq.
	centre := (minFreq + (range / 2)) rounded.
	minFreq := centre - range max: ((self scanData at: 1) at: 2).
	maxFreq := centre + range min: ((self scanData at: self scanData numberOfRows) at: 2). 
	rows := self scanData select: [ :each |
		(each at: 2) >= minFreq and: [ (each at: 2) <= maxFreq ] ].
	^DataFrame fromRows: rows asArray