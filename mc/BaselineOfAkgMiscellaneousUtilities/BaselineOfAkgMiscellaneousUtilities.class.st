Class {
	#name : #BaselineOfAkgMiscellaneousUtilities,
	#superclass : #BaselineOf,
	#category : #BaselineOfAkgMiscellaneousUtilities
}

{ #category : #baseline }
BaselineOfAkgMiscellaneousUtilities >> baseline: spec [
	<baseline>
	| packages |

	packages := Array streamContents: [ :stream |
		stream 
			nextPut: #'AKG-AST-Extensions';
			nextPut: #'AKG-CodeAnalysis';
			nextPut: #'AKG-HashDeep';
			nextPut: #'AKG-PharoDotOrg';
			nextPut: #'AKG-Printing'.
		].
	spec for: #common do: [ spec 
		baseline: 'Diacritics' with: 
			[ spec repository: 'github://hernanmd/Diacriticals' ].

		packages do: [ :package |
			spec package: package ].

		spec		
			group: 'default' with: packages;
			group: 'development' with: #('default')
		]
]
