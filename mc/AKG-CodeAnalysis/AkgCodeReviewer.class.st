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

{ #category : 'as yet unclassified' }
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

{ #category : 'as yet unclassified' }
AkgCodeReviewer >> chatForRepositoryNames: aCollection [
	"Answer a running chat performing a code review of the supplied repository names"
	<return: #GtLChat>

	^ self newChat sendMarkdown: 
		(self promptForRepositoryNames: aCollection).
]

{ #category : 'as yet unclassified' }
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
		markdownResponse;
		addTools: GtLTools gt.
	^ chat
]

{ #category : 'as yet unclassified' }
AkgCodeReviewer >> promptForRepositoryNames: aCollection [
	| changedMethods |
	
	aCollection isEmpty:
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
