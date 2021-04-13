private
printCurrentReport
	"Print the currently selected report"
	| cmd args proc |

	currentReport ifNil: [ ^self ].
	processSemaphore := nil.
	self basicSaveCurrentReport.
	(processSemaphore waitTimeoutSeconds: 15) ifTrue: 
		[ self halt: 'Timeout on pdf conversion' ].
	cmd := '/usr/bin/lp'.
	args := { '-d'. 'lbp6020'. '-h'. '192.168.0.41:6631'. '-o'. 'fit-to-page'. '/media/alistair/danielka/share/SanoPlasma/Reports/latest.pdf'. }.
	proc := GtUnixSubprocess new 
		command: cmd;
		arguments: args;
		workingDirectory: currentReport reportDirectory fullName.
	proc runAndWait.
	proc isSuccess
		ifTrue: [ UIManager default inform: 'Successfully printed report' ]
		ifFalse: [ self halt: 'Something went wrong' ].