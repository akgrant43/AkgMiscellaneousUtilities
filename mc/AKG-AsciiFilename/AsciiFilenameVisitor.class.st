"
Example usage:

[[[ 
'cleannames.log' asFileReference writeStreamDo: [ :logStream |
	logger := CustomStreamLogger with: logStream.
	logger runFor: AsciiFilenameSignal during:
		[ rootDir := '/path/to/rootDir'.
		visitor := AsciiFilenameVisitor new
			rootDirectory: rootDir;
			preorder ]].
]]]
 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables
	asciiFilename:		<Object>
	rootDirectory:		<Object>


!!!Implementation Points
"
Class {
	#name : #AsciiFilenameVisitor,
	#superclass : #AbstractEnumerationVisitor,
	#instVars : [
		'rootDirectory',
		'asciiFilename'
	],
	#category : 'AKG-AsciiFilename'
}

{ #category : #initialization }
AsciiFilenameVisitor >> initialize [

	super initialize.
	asciiFilename := AsciiFilename new 
		includeDiacritics: false;
		dryRun: true;
		windowsCompatible: true;
		replacementString: '.';
		yourself.

]

{ #category : #actions }
AsciiFilenameVisitor >> preorder [

	| guide |

	guide := PreorderGuide for: self.
	guide selectChildren: [ :parentEntry | 
		parentEntry isSymlink not and:
			"Don't index git internal directories"
			[ parentEntry basename ~= '.git' and:
			"Don't index Jekyll site directory"
			[ parentEntry basename ~= '_site' ] ] ].
	^self visit: rootDirectory with: guide.
]

{ #category : #accessing }
AsciiFilenameVisitor >> rootDirectory [
	^ rootDirectory
]

{ #category : #accessing }
AsciiFilenameVisitor >> rootDirectory: anObject [
	rootDirectory := anObject asFileReference
]

{ #category : #visiting }
AsciiFilenameVisitor >> visitReference: anEntry [
	| oldBasename newBasename |

	oldBasename := anEntry basename.
	newBasename := asciiFilename clean: oldBasename.
	newBasename = oldBasename ifTrue: [ ^self ].

	AsciiFilenameSignal new 
		oldName: anEntry reference;
		newBasename: newBasename;
		emit.
	anEntry reference renameTo: newBasename.
]
