Class {
	#name : 'AkgOcrUtility',
	#superclass : 'Object',
	#instVars : [
		'semaphore',
		'chat'
	],
	#category : 'AKG-Printing',
	#package : 'AKG-Printing'
}

{ #category : 'as yet unclassified' }
AkgOcrUtility >> convert: imageFileReference to: markdownFileReference [
	| text |

	self newChat.
	chat sendWith: [ :message |
		message images: { imageFileReference }.
		message string: 'Please convert the attached image to markdown.  Ignore images and diagrams in the document (but include references to the images and diagrams).  Mathematical formulas should be represented using embedded latex.' ].
	semaphore wait.
	text := chat messages last contentText.
	markdownFileReference writeStreamDo: [ :stream |
		stream nextPutAll: text ].
]

{ #category : 'private accessing' }
AkgOcrUtility >> newChat [

	semaphore := Semaphore new.
	chat := GtLModelFactory qwenChat.
	chat
		when: GtLChatExecutionStateChanged
		send: #signalSemaphoreOnFinished:
		to: self.
	^ chat
]

{ #category : 'private' }
AkgOcrUtility >> signalSemaphoreOnFinished: aStateChange [

	aStateChange state
		ifCanStop: [] 
		ifStopping: [] 
		ifIdle: [ semaphore signal ].
]
