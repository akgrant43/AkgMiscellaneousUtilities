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
	#name : #SanoPlasmaScanDirectory,
	#superclass : #Object,
	#instVars : [
		'sanoPlasma'
	],
	#category : 'AKG-SanoPlasma-Model'
}

{ #category : #'instance creation' }
SanoPlasmaScanDirectory class >> default [
	"Answer the default Scan directory"

	^self on: SanoPlasma default
]

{ #category : #'instance creation' }
SanoPlasmaScanDirectory class >> on: aSanoPlasma [
	"Answer an instance of the receiver on the supplied SanoPlasma"

	^self new sanoPlasma: aSanoPlasma 
]

{ #category : #accessing }
SanoPlasmaScanDirectory >> directory [
	^ sanoPlasma rootDirectory / 'ScanData'
]

{ #category : #private }
SanoPlasmaScanDirectory >> fileNameDate: aFileReference [
	"Answer the date encoded in the supplied file.
	The filename is assumed to be DDMMYYYYxxxx"

	| regex day month year |

	regex := '(\d\d)(\d\d)(\d\d\d\d)\d*.csv' asRegexIgnoringCase.
	regex matches: aFileReference basename.
	day := regex subexpression: 2.
	month := regex subexpression: 3.
	year := regex subexpression: 4.
	^Date year: year asInteger month: month asInteger day: day asInteger.
]

{ #category : #inspecting }
SanoPlasmaScanDirectory >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite fastTable 
		title: 'Results';
		display: [ self sortedFiles ];
		column: 'Name' evaluated: [:each | each basename ] width: 400;
		column: 'Size' evaluated: [:each | each humanReadableSize] width: 100;
		column: 'Modified' evaluated: [ :each | 
			String streamContents: [:s | 
				each modificationTime printYMDOn: s.
				s nextPut: Character space.
				each creationTime printHMSOn: s ]];
		icon: [ :each | 
			each isDirectory 
				ifTrue: [ GLMUIThemeExtraIcons glamorousFolder ] 
				ifFalse: [ GLMUIThemeExtraIcons glamorousBrowse ] ];
		when: [self directory isDirectory and: [self directory hasChildren]];
		selectionAct: [:table | table selection delete. table update] entitled: 'Delete';
		act: [ :table |
			 (UIManager default request: 'New Directory name?' initialAnswer: '') 
					ifNotNil: [:name | (self directory / name) ensureCreateDirectory ].
			 table update
			 ] icon: GLMUIThemeExtraIcons glamorousFolder entitled: 'Create Directory';		
		act: [ :table |
			 (UIManager default request: 'New File name?' initialAnswer: '') 
					ifNotNil: [:name | (self directory / name) ensureCreateFile ].
			 table update
			 ] icon: GLMUIThemeExtraIcons glamorousBrowse entitled: 'Create File';		
		act: [ :table | table update ] icon: GLMUIThemeExtraIcons glamorousRefresh entitled: 'Refresh';
		send: [ :selection | SanoPlasmaScanResults on: selection ]
]

{ #category : #accessing }
SanoPlasmaScanDirectory >> sanoPlasma [
	^ sanoPlasma
]

{ #category : #accessing }
SanoPlasmaScanDirectory >> sanoPlasma: anObject [
	sanoPlasma := anObject
]

{ #category : #private }
SanoPlasmaScanDirectory >> sortedFiles [
	"Answer the receivers list of reports and directories"
	| files |

	files := self directory files select: [ :each | 
		(each basename endsWith: '.csv') and:
		[ (SanoPlasmaScanResults on: each sanoPlasma: sanoPlasma) scanData isNotNil ] ].
	files := files sorted: [ :a :b |
		a creationTime > b creationTime ].
	^ files
]
