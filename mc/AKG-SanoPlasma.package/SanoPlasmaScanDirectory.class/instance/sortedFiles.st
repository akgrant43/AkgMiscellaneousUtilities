private
sortedFiles
	"Answer the receivers list of reports and directories"

	| results files |

	results := OrderedCollection new.
	self directory isRoot ifFalse: [ results add: self directory parent ].
	results addAll: self directory directories asSortedCollection.
	files := self directory files select: [ :each | each basename endsWith: '.csv' ].
	"files := files asSortedCollection: [ :a :b | 
		(self fileNameDate: a) > (self fileNameDate: b) ]."
	files := files asSortedCollection: [ :a :b |
		a creationTime > b creationTime ].
	results addAll: files.
	^results