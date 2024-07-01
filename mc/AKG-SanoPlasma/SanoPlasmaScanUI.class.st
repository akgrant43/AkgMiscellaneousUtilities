Class {
	#name : #SanoPlasmaScanUI,
	#superclass : #ComposablePresenter,
	#instVars : [
		'sanoPlasma',
		'scanDirectory',
		'currentReport',
		'menu',
		'directoryList',
		'reportInspector',
		'inRebuild',
		'processSemaphore'
	],
	#category : 'AKG-SanoPlasma-UI'
}

{ #category : #specs }
SanoPlasmaScanUI class >> defaultSpec [
	<spec: #default>

	^SpecColumnLayout composed
		newRow: [ :row | row add: #menu ] height: 30;
		newRow: [ :row | row 
			add: #directoryList width: 300;
			add: #reportInspector ].
]

{ #category : #specs }
SanoPlasmaScanUI class >> title [

	^'SanoPlasma Scan Results'
]

{ #category : #private }
SanoPlasmaScanUI >> addGlobalMenuItemsTo: group [

	group addItem: [ :item |
			item
				name: 'Exit';
				icon: (Smalltalk ui icons iconNamed: #smallQuit);
				action: [ Smalltalk image exit: 0 ] ].
	group addItem: [ :item |
			item
				name: 'Refresh';
				icon: (Smalltalk ui icons iconNamed: #glamorousRefresh);
				action: [ self refreshDirectory ] ].

]

{ #category : #private }
SanoPlasmaScanUI >> addUnixMenuItemsTo: group [

	group addItem: [ :item |
			item
				name: 'Print Report';
				icon: (Smalltalk ui icons iconNamed: #smallPrint);
				action: [ self printCurrentReport ] ].
	group addItem: [ :item |
			item
				name: 'Save Report';
				icon: (Smalltalk ui icons iconNamed: #smallSave);
				action: [ self saveCurrentReport ] ].
	group addItem: [ :item |
			item
				name: 'Refresh';
				icon: (Smalltalk ui icons iconNamed: #glamorousRefresh);
				action: [ self refreshDirectory ] ].
	group addItem: [ :item |
			item
				name: 'Inspect';
				icon: (Smalltalk ui icons iconNamed: #smallObjects);
				action: [ self inspect ] ].
	group addItem: [ :item |
			item
				name: 'Report';
				icon: (Smalltalk ui icons iconNamed: #smallObjects);
				action: [ self currentReport inspect ] ].

]

{ #category : #private }
SanoPlasmaScanUI >> basicSaveCurrentReport [
	"Save the currently selected report"

	| cmdString |

	currentReport ifNil: [ ^self ].
	processSemaphore ifNotNil: [ self error: 'Already processing' ].
	processSemaphore := Semaphore new.
	currentReport saveReportString.
	cmdString := 'enscript -B {1} -o - | ps2pdf - latest.pdf' format: { currentReport reportFilename }.
	[ OSSUnixSubprocess new 
		shellCommand: cmdString;
		workingDirectory: currentReport reportDirectory fullName;
		redirectStderr;
		redirectStdout;
		runAndWaitOnExitDo: [ :cmd :stdout :stderr | 
			cmd isSuccess 
				ifTrue: [ 
					UIManager default inform: 'Successfully converted report to pdf'.
					processSemaphore signal. ]
				ifFalse: [ self error: 'Something went wrong' ] ] ] forkNamed: 'SanoPlasma PDF conversion'.
]

{ #category : #private }
SanoPlasmaScanUI >> columnsFor: aFileReference [
	"Answer the array of columns to be used in the directory list, i.e.
	the filename and encoded report date"

	^{
		aFileReference basename.
		"self filenameDate: aFileReference."
		aFileReference creationTime asString.
	}
]

{ #category : #private }
SanoPlasmaScanUI >> createMenu [

	| newMenu |

	newMenu := MenuPresenter new.

	newMenu addGroup: [ :group |
		self addGlobalMenuItemsTo: group.
		OSPlatform current isWindows ifFalse: 
			[ self addUnixMenuItemsTo: group ] ].
	newMenu applyTo: self.
	^newMenu
]

{ #category : #accessing }
SanoPlasmaScanUI >> currentReport [
	^ currentReport
]

{ #category : #accessing }
SanoPlasmaScanUI >> currentReport: anObject [
	currentReport := anObject
]

{ #category : #accessing }
SanoPlasmaScanUI >> directoryList [
	^ directoryList
]

{ #category : #accessing }
SanoPlasmaScanUI >> directoryList: anObject [
	directoryList := anObject
]

{ #category : #private }
SanoPlasmaScanUI >> emptyEditor [
	"Provide a default widget to open the UI with"

	^self newLabel
		label: 'Select a Scan Report';
		yourself.
]

{ #category : #api }
SanoPlasmaScanUI >> extent [

	^900 @ 400
]

{ #category : #private }
SanoPlasmaScanUI >> filenameDate: aFileReference [

	^aFileReference isDirectory ifTrue:
		[ aFileReference modificationTime asDate printString ]
	ifFalse:
		[ (SanoPlasmaScanResults fileNameDate: aFileReference) printString ]
]

{ #category : #initialization }
SanoPlasmaScanUI >> initialize [

	super initialize.
	processSemaphore := nil.
]

{ #category : #initialization }
SanoPlasmaScanUI >> initializeWidgets [

	menu := self createMenu.
	inRebuild := false.

	directoryList := self newMultiColumnList
		displayBlock: [ :entry | self columnsFor: entry ];
		whenSelectedItemChanged: [ :selection | self selectedReport: selection ];
		yourself.

	reportInspector := self emptyEditor.

	
]

{ #category : #accessing }
SanoPlasmaScanUI >> menu [
	^ menu
]

{ #category : #accessing }
SanoPlasmaScanUI >> menu: anObject [
	menu := anObject
]

{ #category : #private }
SanoPlasmaScanUI >> printCurrentReport [
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
]

{ #category : #private }
SanoPlasmaScanUI >> refreshDirectory [
	"Update the list of results"

	self directoryList items: self scanDirectory sortedFiles.
]

{ #category : #accessing }
SanoPlasmaScanUI >> reportInspector [
	^ reportInspector
]

{ #category : #accessing }
SanoPlasmaScanUI >> reportInspector: anObject [
	reportInspector := anObject
]

{ #category : #accessing }
SanoPlasmaScanUI >> sanoPlasma [
	^ sanoPlasma
]

{ #category : #accessing }
SanoPlasmaScanUI >> sanoPlasma: aSanoPlasma [
	sanoPlasma := aSanoPlasma.
	self scanDirectory: (SanoPlasmaScanDirectory on: sanoPlasma).
]

{ #category : #private }
SanoPlasmaScanUI >> saveCurrentReport [
	"Save the currently selected report"

	self basicSaveCurrentReport.
	processSemaphore := nil.
]

{ #category : #accessing }
SanoPlasmaScanUI >> scanDirectory [
	^ scanDirectory
]

{ #category : #accessing }
SanoPlasmaScanUI >> scanDirectory: aSanoPlasmaScanDirectory [

	scanDirectory := aSanoPlasmaScanDirectory.
	self refreshDirectory.
]

{ #category : #private }
SanoPlasmaScanUI >> selectedReport: aFileReference [
	"Display the selected scan results"

	| inspector |

	currentReport := SanoPlasmaScanResults on: aFileReference.
	inspector := GlamourPresentationPresenter new.
	inspector presentationClass: GTInspector startOn: currentReport.
	reportInspector := inspector.
	inRebuild := true.
	self needRebuild: false.
	self buildWithSpecLayout: self class defaultSpec.
	"self applyCurrentSelection."
	inRebuild := false.
]
