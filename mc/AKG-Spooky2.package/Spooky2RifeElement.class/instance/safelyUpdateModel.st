events
safelyUpdateModel
	"Update the receiver's model in the UI thread"

	self enqueueTask: (BlTaskAction new action: [ self updateModel ])