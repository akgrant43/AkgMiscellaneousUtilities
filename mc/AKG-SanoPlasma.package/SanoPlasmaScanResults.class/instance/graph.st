private - inspecting
graph
	"Answer a Roassal2 graph for the receivers data"

	| view grapher buildBlock |

	view := RTView new.
	buildBlock := [ :graphData |
		grapher := RTGrapher new.
		grapher view: view.
		self add: graphData toGrapher: grapher.
		grapher addDecorator: (RTRangeSelector new callback: [ :selectedGroups | 
			| selectedData |
			selectedData := DataFrame fromRows: (selectedGroups collect: #model).
			view cleanAll.
			buildBlock value: selectedData ]).
		view addMenu: 'Reset' callback: [ 
			view cleanAll.
			buildBlock value: self scanData ].
		view addMenu: 'Zoom Out' callback: [ 
			self zoomOutFrom: graphData view: view block: buildBlock ].
		grapher build. ].
	buildBlock value: self scanData.
	^view