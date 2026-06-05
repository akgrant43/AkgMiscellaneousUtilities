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
	#name : 'AkgTextTranslationUtility',
	#superclass : 'Object',
	#instVars : [
		'inFile',
		'outFile',
		'srcLanguage',
		'dstLanguage',
		'srcLanguageName',
		'dstLanguageName',
		'semaphore',
		'chat',
		'srcText'
	],
	#category : 'AKG-Printing',
	#package : 'AKG-Printing'
}

{ #category : 'api' }
AkgTextTranslationUtility class >> czEnText: aString [

	^ self new
		text: aString;
		translate
]

{ #category : 'api' }
AkgTextTranslationUtility class >> enCzText: aString [

	^ self new
		setEnCz;
		text: aString;
		translate
]

{ #category : 'ui' }
AkgTextTranslationUtility class >> gtTranslatorFor: aView [
	<gtClassView>

	^ aView forward
		title: 'Translate';
		priority: 10;
		object: [ self new ];
		view: #gtTranslatorFor:
]

{ #category : 'api' }
AkgTextTranslationUtility class >> srcDir: srcDir matching: aString dstDir: dstDir [
	| files |

	files := srcDir asFileReference childrenMatching: aString.
	files do: [ :srcFile | | dstFile |
		dstFile := dstDir / (srcFile withExtension: 'txt') basename.
		self new
			inFile: srcFile;
			outFile: dstFile;
			translate. ].
]

{ #category : 'accessing' }
AkgTextTranslationUtility >> dstLanguage [
	^ dstLanguage
]

{ #category : 'accessing' }
AkgTextTranslationUtility >> dstLanguage: anObject [
	dstLanguage := anObject
]

{ #category : 'ui' }
AkgTextTranslationUtility >> gtTranslatorFor: aView [
	<gtView>
	^ aView explicit
		title: 'Translate';
		priority: 10;
		stencil: [ 
			| container inputEditor outputEditor czEnButton enCzButton copyButton insets |
			container := BrVerticalPane new
				matchParent.
			insets := BlInsets left: 5.
			inputEditor := BrEditor new
				aptitude: BrGlamorousRegularEditorAptitude new ";
				text: self sourceText asRopedText".
			outputEditor := BrEditor new
				aptitude: BrGlamorousRegularEditorAptitude new ";
				text: self translatedText asRopedText";
				beReadOnlyWithSelection.
			czEnButton := BrButton new
				aptitude: BrGlamorousButtonWithLabelAptitude;
				label: 'CZ->EN';
				margin: insets;
				action: [ outputEditor text: (self class czEnText: inputEditor text asString) asRopedText ].
			enCzButton := BrButton new
				aptitude: BrGlamorousButtonWithLabelAptitude;
				label: 'EN->CZ';
				margin: insets;
				action: [ outputEditor text: (self class enCzText: inputEditor text asString) asRopedText ].
			copyButton := BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons copyToClipboard;
				margin: insets;
				action: [ Clipboard default clipboardText: outputEditor text asString ].
			container
				addChild: inputEditor;
				addChild: (BrHorizontalPane new
					hMatchParent;
					addChild: czEnButton;
					addChild: enCzButton;
					addChild: copyButton);
				addChild: outputEditor ]
]

{ #category : 'accessing' }
AkgTextTranslationUtility >> inFile [
	^ inFile
]

{ #category : 'accessing' }
AkgTextTranslationUtility >> inFile: aFileReference [

	inFile := aFileReference
]

{ #category : 'as yet unclassified' }
AkgTextTranslationUtility >> initialize [

	super initialize.
	self setCzEn.
]

{ #category : 'as yet unclassified' }
AkgTextTranslationUtility >> newChat [

	semaphore := Semaphore new.
	chat := GtLModelFactory translateChat.
	chat
		when: GtLChatExecutionStateChanged
		send: #signalSemaphoreOnFinished:
		to: self.
	^ chat
]

{ #category : 'as yet unclassified' }
AkgTextTranslationUtility >> outBasename: aString [

	outFile := inFile asFileReference parent / aString
]

{ #category : 'accessing' }
AkgTextTranslationUtility >> outFile [
	^ outFile
]

{ #category : 'accessing' }
AkgTextTranslationUtility >> outFile: aFileReference [

	outFile := aFileReference
]

{ #category : 'as yet unclassified' }
AkgTextTranslationUtility >> setCzEn [

	srcLanguage := 'cs'.
	srcLanguageName := 'Czech'.
	dstLanguage := 'en'.
	dstLanguageName := 'English'.
]

{ #category : 'as yet unclassified' }
AkgTextTranslationUtility >> setEnCz [

	srcLanguage := 'en'.
	srcLanguageName := 'English'.
	dstLanguage := 'cs'.
	dstLanguageName := 'Czech'.
]

{ #category : 'as yet unclassified' }
AkgTextTranslationUtility >> signalSemaphoreOnFinished: aStateChange [

	aStateChange state
		ifCanStop: [] 
		ifStopping: [] 
		ifIdle: [ semaphore signal ].
]

{ #category : 'accessing' }
AkgTextTranslationUtility >> srcLanguage [
	^ srcLanguage
]

{ #category : 'accessing' }
AkgTextTranslationUtility >> srcLanguage: anObject [
	srcLanguage := anObject
]

{ #category : 'as yet unclassified' }
AkgTextTranslationUtility >> text: aString [
	"Set the supplied string as the input file"

	inFile := FileReference newTempFilePrefix: 'AkgTextTranslationUtility-' suffix: '.txt'.
	inFile writeStreamDo: [ :stream |
		stream << aString withUnixLineEndings ].
]

{ #category : 'api' }
AkgTextTranslationUtility >> translate [
	"Translate the specified file"
	| command sourceText translatedText outFr |

	sourceText := inFile
		ifNil: [ srcText ]
		ifNotNil: [ inFile asFileReference contents ].
	sourceText ifNil: [ self error: 'No source text supplied' ].
	command := String streamContents: [ :stream |
		stream nextPutAll:
'You are a professional Czech (cs) to English (en-AU) translator. Your goal is to accurately convey the meaning and nuances of the original Czech text while adhering to English grammar, vocabulary, and cultural sensitivities.
Produce only the English translation, without any additional explanations or commentary.  Do not convert math notation in to unicode symbols, but leave it as latex formatted expressions.  Please translate the following Czech text into English:


'.
		stream nextPutAll: sourceText. ].
	self newChat.
	chat sendString: command.
	semaphore wait.
	translatedText := chat messages last contentText.
	outFile ifNotNil:
		[ outFr := outFile asFileReference.
		outFr writeStreamDo: [ :stream |
			stream nextPutAll: translatedText ] ].
	^ translatedText.
]
