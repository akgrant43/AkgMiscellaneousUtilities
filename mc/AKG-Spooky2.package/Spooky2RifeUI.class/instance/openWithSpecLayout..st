api
openWithSpecLayout: aSpec

	super openWithSpecLayout: aSpec.
	self window whenClosedDo: 
		[ Stdio stdout << 'Closing port.'; lf.
		model close ].