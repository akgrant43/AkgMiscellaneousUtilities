private
saveCurrentReport
	"Save the currently selected report"

	self basicSaveCurrentReport.
	processSemaphore := nil.