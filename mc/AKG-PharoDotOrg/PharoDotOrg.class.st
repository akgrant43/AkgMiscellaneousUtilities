Class {
	#name : #PharoDotOrg,
	#superclass : #Object,
	#instVars : [
		'vm32',
		'vm64',
		'rootNodes'
	],
	#category : 'AKG-PharoDotOrg'
}

{ #category : #'world menu' }
PharoDotOrg class >> pharoDotOrgMenuOn: aBuilder [
	<worldMenu>

	(aBuilder item: #AKG) with: [ 
		(aBuilder item: 'Pharo.org')
			parent: #AKG;
			action: [ [ PharoDotOrg new inspect ] forkAt: 20 ] ]
]

{ #category : #accessing }
PharoDotOrg >> armv632URL [
	"Answer the URL where the ARM v6 32 bit VMs are stored"

	^'http://files.pharo.org/vm/pharo-spur32/linux/armv6'
]

{ #category : #private }
PharoDotOrg >> dateFrom: aString [
	"Answer a date encoded in the supplied string"

	^[ DateAndTime fromString: aString ]
		on: Error 
		do: [ nil ].
]

{ #category : #private }
PharoDotOrg >> dateFromName: aString [
	"Answer a date encoded in the file name.
	The date must be encoded YYYYMMDD have a year of 2018 - 2028"

	| dateRegex found year month day |

	dateRegex := '(\d\d\d\d)(\d\d)(\d\d)' asRegex.
	found := dateRegex search: aString.
	found ifFalse: [ ^nil ].
	year := (dateRegex subexpression: 2) asNumber.
	(year between: 2018 and: 2028) ifFalse: [ ^nil ].
	month := (dateRegex subexpression: 3) asNumber.
	(month between: 1 and: 12) ifFalse: [ ^nil ].
	day := (dateRegex subexpression: 4) asNumber.
	(day between: 1 and: 31) ifFalse: [ ^nil ].
	^Date 	year: year month: month day: day.
]

{ #category : #private }
PharoDotOrg >> download: fileName from: aStringURL [
	"Download the requested file from the supplied directory (URL)"

	| fullURL response downloadDir |

	fullURL := self downloadURL: fileName from: aStringURL.
	downloadDir := FileLocator home / 'Downloads'.
	self assert: downloadDir isDirectory.
	response := ZnEasy get: fullURL.
	(downloadDir / fileName) binaryWriteStreamDo: [ :stream |
		response writeOn: stream ].
	UIManager inform: 'Downloaded ', fileName.
]

{ #category : #private }
PharoDotOrg >> downloadURL: fileName from: aStringURL [
	"Answer the download URL for the requested file and location"

	| fullURL |

	fullURL := (aStringURL last = $/) 
		ifTrue: [ aStringURL, fileName ]
		ifFalse: [ aStringURL, '/', fileName ].
	^fullURL
]

{ #category : #inspecting }
PharoDotOrg >> gtInspect32BitVMsIn: composite [
	<gtInspectorPresentationOrder: 2>

	^composite fastTable 
		title: '32bit VMs';
		display: [ self recentVMsAt: self vm32URL ];
		column: 'Name' evaluated: [ :each | each first ] width: 400;
		column: 'Date' evaluated: [ :each | each second ];
		column: 'Size' evaluated: [ :each | each third ];
		selectionAct: [ :table | self download: table selection first from: self vm32URL ] 
			entitled: 'Download'.

]

{ #category : #inspecting }
PharoDotOrg >> gtInspect64BitVMsIn: composite [
	<gtInspectorPresentationOrder: 1>

	^composite fastTable 
		title: '64bit VMs';
		display: [ self recentVMsAt: self vm64URL ];
		column: 'Name' evaluated: [ :each | each first ] width: 400;
		column: 'Date' evaluated: [ :each | each second ];
		column: 'Size' evaluated: [ :each | each third ];
		selectionAct: [ :table | self download: table selection first from: self vm64URL ] 
			entitled: 'Download'.

]

{ #category : #inspecting }
PharoDotOrg >> gtInspectArmV632BitVMsIn: composite [
	<gtInspectorPresentationOrder: 10>

	^composite fastTable 
		title: 'ARM v6 32bit VMs';
		display: [ self recentVMsAt: self armv632URL ];
		column: 'Name' evaluated: [ :each | each first ] width: 400;
		column: 'Date' evaluated: [ :each | each second ];
		column: 'Size' evaluated: [ :each | each third ];
		selectionAct: [ :table | self download: table selection first from: self vm32URL ] 
			entitled: 'Download'.

]

{ #category : #inspecting }
PharoDotOrg >> gtInspectMac32BitVMsIn: composite [
	<gtInspectorPresentationOrder: 10>

	^composite fastTable 
		title: 'Mac 32bit VMs';
		display: [ self recentVMsAt: self mac32URL ];
		column: 'Name' evaluated: [ :each | each first ] width: 400;
		column: 'Date' evaluated: [ :each | each second ];
		column: 'Size' evaluated: [ :each | each third ];
		selectionAct: [ :table | self download: table selection first from: self vm64URL ] 
			entitled: 'Download'.

]

{ #category : #inspecting }
PharoDotOrg >> gtInspectMac64BitVMsIn: composite [
	<gtInspectorPresentationOrder: 10>

	^composite fastTable 
		title: 'Mac 64bit VMs';
		display: [ self recentVMsAt: self mac64URL ];
		column: 'Name' evaluated: [ :each | each first ] width: 400;
		column: 'Date' evaluated: [ :each | each second ];
		column: 'Size' evaluated: [ :each | each third ];
		selectionAct: [ :table | self download: table selection first from: self vm64URL ] 
			entitled: 'Download'.

]

{ #category : #inspecting }
PharoDotOrg >> gtInspectWin32BitVMsIn: composite [
	<gtInspectorPresentationOrder: 10>

	^composite fastTable 
		title: 'Win 32bit VMs';
		display: [ self recentVMsAt: self win32URL ];
		column: 'Name' evaluated: [ :each | each first ] width: 400;
		column: 'Date' evaluated: [ :each | each second ];
		column: 'Size' evaluated: [ :each | each third ];
		selectionAct: [ :table | self download: table selection first from: self win32URL ] 
			entitled: 'Download'.

]

{ #category : #initialization }
PharoDotOrg >> initialize [

	super initialize.
	rootNodes := Dictionary new.
]

{ #category : #accessing }
PharoDotOrg >> mac32URL [
	"Answer the URL where the Mac 32 bit VMs are stored"

	^'http://files.pharo.org/vm/pharo-spur32/mac/'
]

{ #category : #accessing }
PharoDotOrg >> mac64URL [
	"Answer the URL where the Mac 64 bit VMs are stored"

	^'http://files.pharo.org/vm/pharo-spur64/mac/'
]

{ #category : #accessing }
PharoDotOrg >> recentVMsAt: aURLString [
	"Answer a list of recent VMs at the supplied URL"

	^self recentVMsFromURL: aURLString node: (self rootNodeAt: aURLString)
]

{ #category : #private }
PharoDotOrg >> recentVMsFromURL: dirURL node: aChromeNode [
	"Answer a list of recent VMs listed on the supplied page (ChromeNode)"

	| tables table rows columnIndex dateIndex sizeIndex nameHeading dateHeading sizeHeading latest sixMonths today fileURL |

	tables := aChromeNode extractTables.
	nameHeading := 'Name'.
	dateHeading := 'Last modified'.
	sizeHeading := 'Size'.
	table := tables detect: [ :tableData | tableData first includes: nameHeading ].
	columnIndex := table first indexOf: nameHeading.
	dateIndex := table first indexOf: dateHeading.
	sizeIndex := table first indexOf: sizeHeading.
	rows := table collect: [ :each | | entry |
		entry := each at: columnIndex.
		fileURL := self downloadURL: entry from: dirURL.
		{ entry. (self dateFrom: (each at: dateIndex)). (each at: sizeIndex). fileURL. } ].
	rows := rows select: [ :each | each second isNotNil ].
	today := Date today.
	sixMonths := Duration weeks: 26.
	rows := rows select: [ :each | 
		each second isNotNil and: [ (today - each second) < sixMonths ] ].
	latest := table select: [ :each | (each at: columnIndex) includesSubstring: 'latest' ].
	latest := latest collect: [ :each | 
		{ (each at: columnIndex). (Date fromString: (each at: dateIndex)). (each at: sizeIndex). } ].
	rows := rows, latest.
	rows := rows sorted: [ :a :b | a second > b second ].
	^rows
]

{ #category : #private }
PharoDotOrg >> rootNodeAt: aURLString [
	"Answer the root ChromeNode at aURLString"

	UIManager inform: 'Retrieving ', aURLString asString.
	Processor yield.
	^rootNodes at: aURLString ifAbsentPut: [ 
		GoogleChrome new 
			headless: true;
			get: aURLString ].

]

{ #category : #accessing }
PharoDotOrg >> vm32URL [
	"Answer the URL where the 32 bit VMs are stored"

	^'http://files.pharo.org/vm/pharo-spur32/linux/'
]

{ #category : #accessing }
PharoDotOrg >> vm64URL [
	"Answer the URL where the 64 bit VMs are stored"

	^'http://files.pharo.org/vm/pharo-spur64/linux/'
]

{ #category : #accessing }
PharoDotOrg >> win32URL [
	"Answer the URL where the Win 32 bit VMs are stored"

	^'http://files.pharo.org/vm/pharo-spur32/win/'
]
