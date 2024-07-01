"
SanoPlasma represents an installation on a PC.

SanoPlasma knows the root directory of the installation and provides convenience methods to access the models and open the UI(s).

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #SanoPlasma,
	#superclass : #Object,
	#instVars : [
		'rootDirectory',
		'exportDirectory',
		'reportDirectory',
		'programDB'
	],
	#category : 'AKG-SanoPlasma-Model'
}

{ #category : #accessing }
SanoPlasma class >> default [
	"Find the location of an installation and answer a new instance pointing to it"

	| rootDir exportDir |

	rootDir := #(
		'/tmp/Spooky2'
		'/media/alistair/danielka/share/SanoPlasma/akg/Spooky2'
		'/home/alistair/tmp/Spooky2'
		'C:\Spooky2'
		) detect: [ :each | each asFileReference isDirectory ].
	exportDir := #(
		'/media/alistair/danielka/share/SanoPlasma'
		'/home/alistair/tmp/Spooky2'
		'E:\'
		) detect: [ :each | each asFileReference isDirectory ].
	^self new
		rootDirectory: rootDir asFileReference;
		exportDirectory: exportDir;
		yourself.
]

{ #category : #'user interface' }
SanoPlasma class >> openCrossOverUI [
	<script>

	^self default openCrossOverUI
]

{ #category : #'user interface' }
SanoPlasma class >> openUI [
	<script>

	^self default openUI
]

{ #category : #'world menu' }
SanoPlasma class >> sanoPlasmaMenuOn: aBuilder [
	"Add the SanoPlasma world menu items"
	<worldMenu>

	| sanoPlasma |

	sanoPlasma := aBuilder item: #SanoPlasma.
	sanoPlasma with: [ 
		(aBuilder item: #Chains)
			parent: #SanoPlasma;
			action: [ SanoPlasma default openUI ].
		(aBuilder item: #ScanResults)
			parent: #SanoPlasma;
			action: [ SanoPlasma default openScanUI ].
		(aBuilder item: #CrossOverUI)
			parent: #SanoPlasma;
			action: [ SanoPlasma default openCrossOverUI ] ]
]

{ #category : #accessing }
SanoPlasma >> allChains [
	"Answer a flat collection of all the receiver's presets"

	| presets |

	presets := ((self rootDirectory / 'Preset Collections') allFiles 
		select: [ :each | each extension = 'txt' ])
		collect: [ :each | 
			[ SanoPlasmaChain fromFile: each ]
				on: UTF8InvalidText, AssertionFailure
				do: [nil]].
	^presets select: [ :each | each isNotNil ].
]

{ #category : #accessing }
SanoPlasma >> exportDirectory [
	^ exportDirectory
]

{ #category : #accessing }
SanoPlasma >> exportDirectory: aFileReference [
	"Set the export directory to the supplied reference.
	Ensure the directory exists and update the report directory."

	exportDirectory := aFileReference asFileReference.
	self assert: exportDirectory exists.
	self assert: exportDirectory isDirectory.
	self reportDirectory: exportDirectory / 'Reports'.

]

{ #category : #'user interface' }
SanoPlasma >> openCrossOverUI [
	"Open the CrossOver UI for the receiver"

	^SanoPlasmaCrossOverUI new 
		sanoPlasma: self;
		openWithSpec.
]

{ #category : #'user interface' }
SanoPlasma >> openScanUI [
	"Open the Scan UI for the receiver"

	^SanoPlasmaScanUI new 
		sanoPlasma: self;
		openWithSpec.
]

{ #category : #'user interface' }
SanoPlasma >> openUI [
	"Open the UI for the receiver"

	^SanoPlasmaUI new 
		sanoPlasma: self;
		openWithSpec.
]

{ #category : #models }
SanoPlasma >> programDB [

	^programDB ifNil: [ programDB := SanoPlasmaProgramDB rootDirectory: rootDirectory ]
]

{ #category : #accessing }
SanoPlasma >> reportDirectory [
	^ reportDirectory
]

{ #category : #accessing }
SanoPlasma >> reportDirectory: aFileReference [
	"Set the report directory to the supplied reference.
	Ensure the parent directory exists and create if necessary."

	reportDirectory := aFileReference asFileReference.
	self assert: reportDirectory parent exists.
	reportDirectory ensureCreateDirectory
]

{ #category : #accessing }
SanoPlasma >> rootDirectory [
	^ rootDirectory
]

{ #category : #accessing }
SanoPlasma >> rootDirectory: anObject [
	rootDirectory := anObject
]
