private
downloadURL: fileName from: aStringURL
	"Answer the download URL for the requested file and location"

	| fullURL |

	fullURL := (aStringURL last = $/) 
		ifTrue: [ aStringURL, fileName ]
		ifFalse: [ aStringURL, '/', fileName ].
	^fullURL