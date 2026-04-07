"
SanoPlasmaScanDirectory provides convenient inspection and access to scan results.


Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	directory:		<Object>


    Implementation Points
"
Class {
	#name : 'SanoPlasmaScanDirectory',
	#superclass : 'Object',
	#instVars : [
		'sanoPlasma'
	],
	#category : 'AKG-SanoPlasma-Model',
	#package : 'AKG-SanoPlasma',
	#tag : 'Model'
}

{ #category : 'instance creation' }
SanoPlasmaScanDirectory class >> default [
	"Answer the default Scan directory"

	^self on: SanoPlasma default
]

{ #category : 'private' }
SanoPlasmaScanDirectory class >> fileNameDate1: aFileReference [
	"Answer the date encoded in the supplied file.
	The filename is assumed to be DDMMYYYYxxxx"

	| regex day month year |

	regex := '(\d\d)(\d\d)(\d\d\d\d)\d*.csv' asRegexIgnoringCase.
	(regex matches: aFileReference basename) ifFalse: [ ^ nil ].
	day := regex subexpression: 2.
	month := regex subexpression: 3.
	year := regex subexpression: 4.
	^Date year: year asInteger month: month asInteger day: day asInteger.
]

{ #category : 'private' }
SanoPlasmaScanDirectory class >> fileNameDate2: aFileReference [
	"Answer the date encoded in the supplied file.
	The filename is assumed to be DDMMYYYYxxxx"
	| basename regex day month year hour minute |

	basename := aFileReference basename.
	regex := 'BFB_(\d\d\d\d)(\d\d)(\d\d)_(\d\d)(\d\d).*.csv' asRegexIgnoringCase.
	(regex matches: aFileReference basename) ifFalse: [ ^ nil ].
	day := regex subexpression: 4.
	month := regex subexpression: 3.
	year := regex subexpression: 2.
	hour := regex subexpression: 5.
	minute := regex subexpression: 6.
	^DateAndTime year: year asInteger month: month asInteger day: day asInteger hour: hour asInteger minute: minute asInteger.
]

{ #category : 'private' }
SanoPlasmaScanDirectory class >> fileNameDate: aFileReference [
	"Answer the date encoded in the supplied file"

	(self fileNameDate1: aFileReference)
		ifNotNil: [ :date | ^ date ].
	(self fileNameDate2: aFileReference)
		ifNotNil: [ :date | ^ date ].
	^ nil
]

{ #category : 'instance creation' }
SanoPlasmaScanDirectory class >> on: aSanoPlasma [
	"Answer an instance of the receiver on the supplied SanoPlasma"

	^self new sanoPlasma: aSanoPlasma 
]

{ #category : 'accessing' }
SanoPlasmaScanDirectory >> directory [
	^ sanoPlasma rootDirectory / 'ScanData'
]

{ #category : 'as yet unclassified' }
SanoPlasmaScanDirectory >> gtViewFilesFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Files';
		priority: 10;
		items: [ self sortedFiles ];
		column: 'Name' text: #basename;
		column: 'Size' text: #size;
		column: 'Modified' text: #modificationTime;
		send: [ :fileReference | SanoPlasmaScanResults on: fileReference ].
]

{ #category : 'accessing' }
SanoPlasmaScanDirectory >> sanoPlasma [
	^ sanoPlasma
]

{ #category : 'accessing' }
SanoPlasmaScanDirectory >> sanoPlasma: anObject [
	sanoPlasma := anObject
]

{ #category : 'private' }
SanoPlasmaScanDirectory >> sortedFiles [
	"Answer the receivers list of reports and directories"
	| files |

	files := self directory files select: [ :each | 
		(each extension = 'csv') and:
		[ (SanoPlasmaScanResults on: each sanoPlasma: sanoPlasma) scanData isNotNil ] ].
	files := files sorted: [ :a :b |
		(SanoPlasmaScanDirectory fileNameDate: a) > (SanoPlasmaScanDirectory fileNameDate: b) ].
	^ files
]
