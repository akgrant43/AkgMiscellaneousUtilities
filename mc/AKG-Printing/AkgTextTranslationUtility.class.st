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
		'chat'
	],
	#category : 'AKG-Printing',
	#package : 'AKG-Printing'
}

{ #category : 'accessing' }
AkgTextTranslationUtility >> dstLanguage [
	^ dstLanguage
]

{ #category : 'accessing' }
AkgTextTranslationUtility >> dstLanguage: anObject [
	dstLanguage := anObject
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
	srcLanguage := 'cs'.
	srcLanguageName := 'Czech'.
	dstLanguage := 'en'.
	dstLanguageName := 'English'.
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
	| command inFr outFr |

	inFr := inFile asFileReference contents.
	outFr := outFile asFileReference.
	command := String streamContents: [ :stream |
		stream nextPutAll:
'You are a professional Czech (cs) to English (en-AU) translator. Your goal is to accurately convey the meaning and nuances of the original Czech text while adhering to English grammar, vocabulary, and cultural sensitivities.
Produce only the English translation, without any additional explanations or commentary.  Do not convert math notation in to unicode symbols, but leave it as latex formatted expressions.  Please translate the following Czech text into English:


'.
		stream nextPutAll: inFr. ].
	self newChat.
	chat sendString: command.
	semaphore wait.
	outFr writeStreamDo: [ :stream |
		stream nextPutAll: chat messages last contentText ].
]
