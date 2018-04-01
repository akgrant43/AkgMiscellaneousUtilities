accessing
recentVMsAt: aURLString
	"Answer a list of recent VMs at the supplied URL"

	^self recentVMsFromNode: (self rootNodeAt: aURLString)