private
printCurrentReport
	"Print the currently selected report"

	| cmdString |
self halt.
	currentReport ifNil: [ ^self ].
	processSemaphore := nil.
	self basicSaveCurrentReport.
	(processSemaphore waitTimeoutSeconds: 15) ifTrue: 
		[ self halt: 'Timeout on pdf conversion' ].
	cmdString := 'lp -d lbp6020 -h 192.168.0.41:6631 -o fit-to-page /media/alistair/danielka/share/SanoPlasma/Reports/latest.pdf'.
	[ OSSUnixSubprocess new 
		shellCommand: cmdString;
		workingDirectory: currentReport reportDirectory fullName;
		redirectStderr;
		redirectStdout;
		runAndWaitOnExitDo: [ :cmd :stdout :stderr | 
			cmd isSuccess 
				ifTrue: [ UIManager default inform: 'Successfully printed report' ]
				ifFalse: [ self halt: 'Something went wrong' ] ] ] forkNamed: 'SanoPlasma Print'.