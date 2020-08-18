api - instantiation
create
	| container |

	container := super create.

	"Add a GtPlotterXMarker as a child of the plot area"
	container children first addChild: self createXMarker.

	^ container