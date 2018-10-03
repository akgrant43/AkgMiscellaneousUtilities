private
pillarToMarkdown: aStream
	"Write the supplied pillar stream to textTemporary, converting to Markdown"

	self textTemporary ensureDelete.
	self textTemporary writeStreamDo: [ :stream | | znstream |
		znstream := ZnNewLineWriterStream on: stream.
		PRMarkdownWriter write: (PRPillarParser parse: aStream) to: znstream ]