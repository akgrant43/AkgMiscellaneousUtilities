private
sortedFiles
	"Answer the receivers list of reports and directories"

	| results files |

	results := OrderedCollection new.
	directory isRoot ifFalse: [ results add: directory parent ].
	results addAll: directory directories asSortedCollection.
	files := directory files select: [ :each | each basename endsWith: '.csv' ].
	files := files asSortedCollection: [ :a :b | 
		(self fileNameDate: a) < (self fileNameDate: b) ].
	results addAll: files.