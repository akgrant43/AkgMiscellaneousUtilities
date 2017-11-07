comparing
missingIn: hashDeepFiles
	"Answer the set of files that the receiver has but hashDeepFiles doesn't"

	^hashDeepFiles missingFromFiles: self.