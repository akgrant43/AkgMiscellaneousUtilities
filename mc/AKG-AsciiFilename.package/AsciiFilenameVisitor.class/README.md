Example usage:

[[[ 
'cleannames.log' asFileReference writeStreamDo: [ :logStream |
	logger := CustomStreamLogger with: logStream.
	logger runFor: AsciiFilenameSignal during:
		[ rootDir := '/path/to/rootDir'.
		visitor := AsciiFilenameVisitor new
			rootDirectory: rootDir;
			preorder ]].
]]]
 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables
	asciiFilename:		<Object>
	rootDirectory:		<Object>


!!!Implementation Points