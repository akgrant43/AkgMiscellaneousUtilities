api
openWithSpecLayout: aSpec

	super openWithSpecLayout: aSpec.
	self window whenClosedDo: [ model close ].