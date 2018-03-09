private
saveCurrentReport
	"Save the currently selected report"

	currentReport ifNil: [ ^self ].
	currentReport saveReportString.