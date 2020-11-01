api - instantiation
create
	| container |

	container := super create.

	"Add a GtPlotterXMarker as a child of the plot area for each x-marker"
	xValueHolders do: [ :each |
		container children first addChild: (self createXMarkerFor: each) ].

	^ container