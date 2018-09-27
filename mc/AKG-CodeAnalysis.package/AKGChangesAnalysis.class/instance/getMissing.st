private
getMissing
	"Answer the methods that are in the image but not the receiver's file.
	Answer for all classes modified in the change set (based on added and changed methods)"

	| classes selectors classSelectors newMissing |

	"Collect the set of classes and selectors"
	classes := Set new.
	selectors := Dictionary new.
	externalChanges do: [ :change |
		change isMethodDeclaration ifTrue: [ 
			classes add: change targetClass.
			classSelectors := selectors at: change targetClass 
										ifAbsentPut: [ Set new ].
			classSelectors add: change methodSelector ] ].

	"Iterate over all the classes and determine what's missing"
	newMissing := Array streamContents: [ :stream |
		classes do: [ :class |
			class selectors do: [ :selector |
				((selectors at: class) includes: selector) ifFalse: 
					[ stream nextPut: class >> selector ] ] ] ].

	^newMissing