writing
saveIn: aDirectory
	"Write the receiver in aDirectory"

	| fileName stream |

	self assert: aDirectory isDirectory 
		description: aDirectory fullName, ' isn''t a directory'.
	self assert: (name isNotNil and: [ name isNotEmpty ])
		description: 'The Chain name cannot be nil or empty'.

	fileName := aDirectory / name.
	stream := (File named: fileName fullName) writeStream.
	[ self writeOn: (ZnCrPortableWriteStream on: 
							(ZnCharacterWriteStream on: stream encoding: 'utf8')) ]
		ensure: [ stream close ].
