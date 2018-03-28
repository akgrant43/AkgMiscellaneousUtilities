private - inspecting
graph
	"Answer a Roassal2 graph for the receivers data"

	| view grapher buildBlock |

	view := RTView new.
	buildBlock := [ :scanData |
		grapher := RTGrapher new.
		grapher view: view.
		self add: scanData toGrapher: grapher.
		grapher addDecorator: (RTRangeSelector new callback: [ :selectedGroups | 
			| selectedData |
			selectedData := DataFrame fromRows: (selectedGroups collect: #model).
			view cleanAll.
			buildBlock value: selectedData ]).
		grapher build. ].
	buildBlock value: self scanData.
	^view