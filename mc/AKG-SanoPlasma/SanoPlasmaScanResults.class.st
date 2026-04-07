"
SanoPlasmaScanResults interprets the data from a SanoPlasma scan csv file and presents it as: 

- a text report
- a graph

The text report can easily be converted to pdf with: 

enscript -B report.txt -o - | ps2pdf - out.pdf 


Public API and Key Messages

- on: aFileReference - open the supplied results file
- saveReportString - save the text report in the default location (SanoPlasma>>reportDirectory)
 

Internal Representation and Key Implementation Points.

 Instance Variables
	fileReference:		<FileReference> The SanoPlasma data file containing the scan results


    Implementation Points
"
Class {
	#name : 'SanoPlasmaScanResults',
	#superclass : 'Object',
	#instVars : [
		'sanoPlasma',
		'fileReference',
		'reportFrequencyCount',
		'scanData'
	],
	#category : 'AKG-SanoPlasma-Model',
	#package : 'AKG-SanoPlasma',
	#tag : 'Model'
}

{ #category : 'accessing' }
SanoPlasmaScanResults class >> fileNameID: aFileReference [
	"Answer the date encoded in the supplied file.
	The filename is assumed to be DDMMYYYYxxxx"

	| basename extensionStart |

	basename := aFileReference basename.
	extensionStart := basename indexOfSubCollection: '.csv'.
	^basename copyFrom: 9 to: extensionStart-1.
]

{ #category : 'instance creation' }
SanoPlasmaScanResults class >> on: aFileReference [
	"Answer an instance of the receiver for the supplied file"

	^self new 
		fileReference: aFileReference asFileReference;
		sanoPlasma: SanoPlasma default;
		yourself
]

{ #category : 'instance creation' }
SanoPlasmaScanResults class >> on: aFileReference sanoPlasma: aSanoPlasma [
	"Answer an instance of the receiver for the supplied file and equipment"

	^self new 
		fileReference: aFileReference asFileReference;
		sanoPlasma: aSanoPlasma;
		yourself
]

{ #category : 'accessing' }
SanoPlasmaScanResults class >> pageToLineCount [
	"Answer an array that maps the number of pages in the report (array index) to the number of lines"

	^#(58 127 193)
]

{ #category : 'private - inspecting' }
SanoPlasmaScanResults >> add: scanData toGrapher: grapher [
	"Add the supplied scanData to the supplied gapher, setting the labels and offsets as required"

	| frequencies values dataset minFreq maxFreq minValue maxValue averageValue |

	frequencies := scanData columnAt: 2.
	values := scanData columnAt: 3.
	minFreq := frequencies min.
	maxFreq := frequencies max.
	minValue := values min.
	maxValue := values max.
	averageValue := values average.

	"Add the data"
	dataset := RTData new.
	dataset
		noDot;
		points: scanData;
		x: [ :ds | ds second - minFreq ];
		y: [ :ds | ds third - minValue ];
		connectColor: Color blue.
	grapher add: dataset.
	
	"Add a zero line"
"	dataset := RTData new.
	dataset
		noDot;
		points: { { minFreq. 0. }. { maxFreq. 0. }};
		x: [ :ds | ds first - minFreq ];
		y: [ :ds | ds second - minValue ];
		connectColor: Color green.
	grapher add: dataset."

	"Add the average line"
	dataset := RTData new.
	dataset
		noDot;
		points: { { minFreq. averageValue. }. { maxFreq. averageValue. }};
		x: [ :ds | ds first - minFreq ];
		y: [ :ds | ds second - minValue ];
		connectColor: Color gray.
	grapher add: dataset.

	grapher axisX labelConversion: [ :value | value + minFreq ].
	grapher axisY labelConversion: [ :value | (value + minValue) printShowingDecimalPlaces: 1 ].
	^grapher
]

{ #category : 'accessing' }
SanoPlasmaScanResults >> fileReference [
	^ fileReference
]

{ #category : 'accessing' }
SanoPlasmaScanResults >> fileReference: anObject [
	fileReference := anObject
]

{ #category : 'accessing' }
SanoPlasmaScanResults >> filenameDate [
	"Answer the date encoded in the receivers filename"

	^ SanoPlasmaScanDirectory fileNameDate: self fileReference
]

{ #category : 'private - inspecting' }
SanoPlasmaScanResults >> graph [
	"Answer a Roassal2 graph for the receivers data"

	| view grapher buildBlock |

	view := RTView new.
	buildBlock := [ :graphData |
		grapher := RTGrapher new.
		grapher view: view.
		self add: graphData toGrapher: grapher.
		grapher addDecorator: (RTRangeSelector new callback: [ :selectedGroups | 
			| selectedData |
			selectedData := DataFrame fromRows: (selectedGroups collect: #model).
			view cleanAll.
			buildBlock value: selectedData ]).
		view addMenu: 'Reset' callback: [ 
			view cleanAll.
			buildBlock value: self scanData ].
		view addMenu: 'Zoom Out' callback: [ 
			self zoomOutFrom: graphData view: view block: buildBlock ].
		grapher build. ].
	buildBlock value: self scanData.
	^view
]

{ #category : 'inspecting' }
SanoPlasmaScanResults >> gtGraphIn: composite [
	<gtInspectorPresentationOrder: 2>

	composite roassal2
		title: 'Graph';
		initializeView: [ self graph ];
		when: [ self scanData isNotNil ]
]

{ #category : 'inspecting' }
SanoPlasmaScanResults >> gtReportFor: aView [
	<gtView>

	^ aView text
		title: 'Report';
		priority: 10;
		text: [ self reportString asRopedText glamorousCodeFont]
]

{ #category : 'inspecting' }
SanoPlasmaScanResults >> gtScanDataFor: aView [
	<gtView>

	^ aView forward
		title: 'Scan Data';
		priority: 20;
		object: [ self scanData];
		view: #gtTableFor:
]

{ #category : 'initialization' }
SanoPlasmaScanResults >> initialize [

	super initialize.
	self pages: 3.
]

{ #category : 'accessing' }
SanoPlasmaScanResults >> pages: pageCount [
	"Set the reportFrequencyCount to the number matching the number of pages"

	^self reportFrequencyCount: (self class pageToLineCount at: pageCount)
]

{ #category : 'accessing' }
SanoPlasmaScanResults >> rawScanData [
	"Answer the raw scan data as a DataFrame"

	| csv rows header rawData |

	rows := OrderedCollection new.
	self fileReference readStreamDo: [ :stream |
		csv := NeoCSVReader on: stream.
		header := csv readHeader.
		((header includes: 'Frequency (Hz)') or:
			[ header includes: 'Frequency' ]) ifFalse: [ ^ nil ].
		csv do: [ :row |
			rows add: (Array streamContents: [ :array |
				row do: [ :cell | array nextPut: cell asNumberOrNil ] ]) ] ].
	rawData := DataFrame withRows: rows.
	header doWithIndex: [ :title :index |
		title = 'Spare' ifTrue: 
			[ header at: index put: 'Spare', index asString ] ].
	rawData columnNames: header.
	^rawData
]

{ #category : 'reports' }
SanoPlasmaScanResults >> reportDirectory [
	"Answer the default location for saving reports"

	^self sanoPlasma reportDirectory
]

{ #category : 'reports' }
SanoPlasmaScanResults >> reportFilename [
	"Answer the receivers report filename"

	^self fileReference basenameWithoutExtension, '.txt'.

]

{ #category : 'accessing' }
SanoPlasmaScanResults >> reportFrequencyCount [
	^ reportFrequencyCount
]

{ #category : 'accessing' }
SanoPlasmaScanResults >> reportFrequencyCount: anObject [
	reportFrequencyCount := anObject
]

{ #category : 'printing' }
SanoPlasmaScanResults >> reportString [
	| data columnNames columnNumber numRecords sortedByMagnitude sortedByFrequency report |

	data := self scanData.
	data ifNil:
		[ ^self fileReference fullName, ' is not a valid scan results file' ].
	numRecords := reportFrequencyCount min: data size.
	columnNames := data columnNames.
	columnNumber := columnNames detectIndex: [ :name | name beginsWith: 'Magnitude' ]
		ifNone: [ nil ].
	columnNumber ifNil:
		[ columnNumber := columnNames detectIndex: [ :name | name = 'HRV' ]
			ifNone: [ nil ] ].
	columnNumber ifNil:
		[ self error: 'Unable to find column' ].
	sortedByMagnitude := data sorted: [ :a :b | (a at: columnNumber) > (b at: columnNumber) ].
	sortedByMagnitude := sortedByMagnitude first: numRecords.
	sortedByFrequency := sortedByMagnitude sorted: [ :a :b | (a at: 2) < (b at: 2) ].
	report := String streamContents: [ :stream |
		stream
			<< 'Filename: ';
			<< self fileReference basename;
			cr;
			<< 'Date:     ';
			<< (SanoPlasmaScanDirectory fileNameDate: self fileReference) printString;
			cr;
			cr; cr.
		stream
			<< 'Results by Magnitude                  Results by Frequency'; cr;
			<< '====================                  ===================='; cr;
			cr;
			<< 'Freq(Hz)   MonitoredValue             Freq(Hz)   MonitoredValue'; cr;
			<< '--------   --------------             --------   --------------';
			cr.
		1 to: numRecords do: [ :index | | magnitude frequency |
			magnitude := sortedByMagnitude at: index.
			frequency := sortedByFrequency at: index.
			stream
				<< (magnitude second asNumber printPaddedWith: Character space to: 8);
				<< (((magnitude at: columnNumber) asNumber printShowingDecimalPlaces: 2) padLeftTo: 8);
				<< (frequency second asNumber printPaddedWith: Character space to: 28);
				<< (((frequency at: columnNumber) asNumber printShowingDecimalPlaces: 2) padLeftTo: 10);
				cr ].
		 ].
	^report
]

{ #category : 'accessing' }
SanoPlasmaScanResults >> sanoPlasma [
	^ sanoPlasma
]

{ #category : 'accessing' }
SanoPlasmaScanResults >> sanoPlasma: anObject [
	sanoPlasma := anObject
]

{ #category : 'reports' }
SanoPlasmaScanResults >> savePDF [
	"Save the currently selected report"

	| cmdString |

	self saveReportString.
	cmdString := 'enscript -B {1} -o - | ps2pdf - latest.pdf' format: { self reportFilename }.
	[ OSSUnixSubprocess new 
		shellCommand: cmdString;
		workingDirectory: self reportDirectory fullName;
		redirectStderr;
		redirectStdout;
		runAndWaitOnExitDo: [ :cmd :stdout :stderr | 
			cmd isSuccess 
				ifTrue: [ 
					UIManager default inform: 'Successfully converted report to pdf'. ]
				ifFalse: [ self error: 'Something went wrong' ] ] ] 
					forkNamed: 'SanoPlasma PDF conversion'.
]

{ #category : 'reports' }
SanoPlasmaScanResults >> saveReportString [
	"Save the report in the default location"

	^self saveReportStringIn: self sanoPlasma reportDirectory
]

{ #category : 'reports' }
SanoPlasmaScanResults >> saveReportStringIn: aDirectory [
	"Answer the receivers report string in aDirectory"

	| reportName |
	reportName := aDirectory / self reportFilename.
	reportName binaryWriteStreamDo: [ :outputStream |
		(ZnNewLineWriterStream on:
			(ZnCharacterWriteStream on: outputStream encoding: 'utf8'))
				forCrLf;
				nextPutAll: self reportString.
	].
	UIManager default inform: 'Saved report to: ', reportName fullName
]

{ #category : 'accessing' }
SanoPlasmaScanResults >> scanData [
	"Answer the scan data as a DataFrame"

	| rawData columnNames frequencyIndex |

	^scanData ifNil: [ 
		rawData := self rawScanData.
		rawData ifNotNil:
			[ columnNames := rawData columnNames.
			frequencyIndex := (columnNames indexOf: 'Frequency (Hz)') max: (columnNames indexOf: 'Frequency').
			frequencyIndex = 0 ifTrue: [ ^nil ].
			scanData := rawData columnsAt: #(1 2 3 4) ] ].
]

{ #category : 'printing' }
SanoPlasmaScanResults >> textOn: aTextStream [

	aTextStream
		nextPutAll: self reportString;
		applyAttribute: (TextFontReference
					toFont: (LogicalFont 
						familyName: 'Source Code Pro' 
						pointSize: StandardFonts defaultFont pointSize)) beginningAt: 1.
]

{ #category : 'private - inspecting' }
SanoPlasmaScanResults >> zoomOutFrom: graphData view: view block: buildBlock [
	"Answer the dataset with twice the range of the selected data set"

	| minFreq maxFreq range centre rows |

	graphData numberOfRows = self scanData numberOfRows ifTrue: [ 
		UIManager default inform: 'Already zoomed out, ignoring'.
		^nil ].
	minFreq := (graphData at: 1) at: 2.
	maxFreq := (graphData at: graphData numberOfRows) at: 2.
	range := maxFreq - minFreq.
	centre := (minFreq + (range / 2)) rounded.
	minFreq := centre - range max: ((self scanData at: 1) at: 2).
	maxFreq := centre + range min: ((self scanData at: self scanData numberOfRows) at: 2). 
	rows := self scanData select: [ :each | (each at: 2) between: minFreq and: maxFreq ].
	view cleanAll.
	buildBlock value: (DataFrame fromRows: rows asArray)
]
