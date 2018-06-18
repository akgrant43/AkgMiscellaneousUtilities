accessing
recentVMsAt: aURLString
	"Answer a list of recent VMs at the supplied URL"

	^self recentVMsFromURL: aURLString node: (self rootNodeAt: aURLString)