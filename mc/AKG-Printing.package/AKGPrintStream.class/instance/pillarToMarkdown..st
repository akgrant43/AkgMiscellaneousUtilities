private
pillarToMarkdown: aStream
	"Write the supplied pillar stream to textTemporary, converting to Markdown"

	| markdown |
	markdown := String streamContents: [ :stream |
		PRMarkdownWriter write: (PRPillarParser parse: aStream) to: stream ].
	self textTemporary ensureDelete.
	self textTemporary writeStreamDo: 
		[ :stream | stream asNewLineStream nextPutAll: markdown ]