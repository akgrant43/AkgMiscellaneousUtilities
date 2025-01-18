"
Typical Czech to English document translation:

```
src := '/home/alistair/Documents/Properties/Prague Flats/Rumburska 255-5/2024/Eva/2025-01-18 Preparation/2025-01-18 Libal odvolání.txt' asFileReference.
dst := '/home/alistair/Documents/Properties/Prague Flats/Rumburska 255-5/2024/Eva/2025-01-18 Preparation/2025-01-18 Libal odvolání en.txt' asFileReference.
AkgTextTranslationUtility new
	inFile: src;
	outFile: dst;
	translate.
```



"
Class {
	#name : #AkgTextTranslationUtility,
	#superclass : #Object,
	#instVars : [
		'inFile',
		'outFile',
		'srcLanguage',
		'dstLanguage'
	],
	#category : #'AKG-Printing'
}

{ #category : #accessing }
AkgTextTranslationUtility >> dstLanguage [
	^ dstLanguage
]

{ #category : #accessing }
AkgTextTranslationUtility >> dstLanguage: anObject [
	dstLanguage := anObject
]

{ #category : #accessing }
AkgTextTranslationUtility >> inFile [
	^ inFile
]

{ #category : #accessing }
AkgTextTranslationUtility >> inFile: aFileReference [

	inFile := aFileReference
]

{ #category : #'as yet unclassified' }
AkgTextTranslationUtility >> initialize [

	super initialize.
	srcLanguage := 'cs'.
	dstLanguage := 'en'.
]

{ #category : #'as yet unclassified' }
AkgTextTranslationUtility >> outBasename: aString [

	outFile := inFile asFileReference parent / aString
]

{ #category : #accessing }
AkgTextTranslationUtility >> outFile [
	^ outFile
]

{ #category : #accessing }
AkgTextTranslationUtility >> outFile: aFileReference [

	outFile := aFileReference
]

{ #category : #accessing }
AkgTextTranslationUtility >> srcLanguage [
	^ srcLanguage
]

{ #category : #accessing }
AkgTextTranslationUtility >> srcLanguage: anObject [
	srcLanguage := anObject
]

{ #category : #'as yet unclassified' }
AkgTextTranslationUtility >> text: aString [
	"Set the supplied string as the input file"

	inFile := FileReference newTempFilePrefix: 'AkgTextTranslationUtility-' suffix: '.txt'.
	inFile writeStreamDo: [ :stream |
		stream << aString withUnixLineEndings ].
]

{ #category : #api }
AkgTextTranslationUtility >> translate [
	"Translate the specified file"
	| command arguments inFr outFr builder status proc stdout stderr |

	inFr := inFile asFileReference.
	outFr := outFile asFileReference.
	command := 'trans'.
	arguments := Array streamContents: [ :stream |
		stream
			nextPut: '-b';
			nextPut: '-s';
			nextPut: srcLanguage;
			nextPut: '-i';
			nextPut: inFr fullName;
			nextPut: '-t';
			nextPut: dstLanguage;
			nextPut: '-o';
			nextPut: outFr fullName ].
	builder := GtExternalProcessBuilder new
		command: command;
		arguments: arguments;
		pipeStdout;
		pipeStderr.
	command := builder createNativeCommand.
	proc := command spawn.
	status := command status.
	status isSuccess ifFalse: 
		[ stdout := String cr join: proc stdoutStream lines toArray wait.
		stderr := String cr join: proc stderrStream lines toArray wait.
		self error: 'phooey' ].
	^ outFr.
]
