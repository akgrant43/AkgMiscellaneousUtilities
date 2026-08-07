Class {
	#name : 'AkgCodeReviewer',
	#superclass : 'Object',
	#category : 'AKG-CodeAnalysis-LLM',
	#package : 'AKG-CodeAnalysis',
	#tag : 'LLM'
}

{ #category : 'instance creation' }
AkgCodeReviewer class >> chatForRepositoryNames: aCollection [

	^ self new chatForRepositoryNames: aCollection
]

{ #category : 'instance creation' }
AkgCodeReviewer class >> chatForRepositoryNames: aCollection promptSuffix: aString [

	^ self new chatForRepositoryNames: aCollection promptSuffix: aString
]

{ #category : 'private' }
AkgCodeReviewer >> changedMethodsForRepositoryNames: aCollection [
	<return: #OrderedCollection of: #IceMethodDefinition>
	| changedMethods repositories nameSet |
	
	changedMethods := OrderedCollection new.
	nameSet := aCollection asSet.
	repositories := IceRepository registry select: [ :repo |
		nameSet includes: repo name ].
	repositories size = aCollection size ifFalse:
		[ self error: 'Missing repositories: ', (nameSet difference: (repositories collect: #name as: Set)) ].
	repositories do: [ :repository |
		| diff |
		diff := repository workingCopy diffToReferenceCommit.
		diff treeToShow  do: [ :eachOperation |
			(eachOperation hasChanges
				and: [ eachOperation definition isMethodDefinition ])
					ifTrue: [ changedMethods add: eachOperation definition ] ] ].
	^ changedMethods
]

{ #category : 'api' }
AkgCodeReviewer >> chatForRepositoryNames: aCollection [
	"Answer a running chat performing a code review of the supplied repository names"
	<return: #GtLChat>

	^ self newChat sendString: 
		(self promptForRepositoryNames: aCollection).
]

{ #category : 'api' }
AkgCodeReviewer >> chatForRepositoryNames: aCollection promptSuffix: aString [
	"Answer a running chat performing a code review of the supplied repository names"
	<return: #GtLChat>
	| prompt |

	prompt := String streamContents: [ :stream |
		stream
			<< (self promptForRepositoryNames: aCollection);
			cr;
			<< aString asString ].
	^ self newChat sendMarkdown: prompt.
]

{ #category : 'private' }
AkgCodeReviewer >> newChat [
	"Answer a chat configured for code review"
	| provider chat |

	provider := GtLOllamaProvider new.
	provider 
		responses;
		baseUrl: 'https://ollama.com' asZnUrl;
		loadApiKeyFromFile;
		modelName: 'kimi-k2.7-code:cloud'.
	chat := GtLChat new provider: provider.
	chat 
		addTools: GtLTools gt.
	^ chat
]

{ #category : 'private' }
AkgCodeReviewer >> promptForRepositoryNames: aCollection [
	| changedMethods |
	
	aCollection ifEmpty:
		[ self error: 'No repository names supplied' ].
	changedMethods := self changedMethodsForRepositoryNames: aCollection.
	^ String streamContents: [ :stream |
		stream 
			<< 'Please perform a code review on the methods listed below:'; lf;
			lf.
		changedMethods do: [ :definition |
			stream
				<< definition className.
			definition classIsMeta ifTrue:
				[ stream << ' class' ].
			stream
				<< '>>#';
				<< definition selector;
				lf ] ].
]
