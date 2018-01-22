writing
saveIn: aDirectory
	"Save the receiver in the supplied directory"

	| fileName stream |

	self assert: aDirectory parent isDirectory description: 'Parent directory must exist'.
	aDirectory ensureCreateDirectory.
	fileName := self fileNameIn: aDirectory.

	"MultiByteFileStream seems to have more and more problems..."
	stream := (File named: fileName fullName) writeStream. 
	[ self writeOn: (ZnCrPortableWriteStream on: 
							(ZnCharacterWriteStream on: stream encoding: 'utf8')) ]
		ensure: [ stream close ].
