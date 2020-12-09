private
markdownToPDF: markdownFileReference
	"Convert the supplied markdown file to pdfTemporary"
	| odtFileReference |

	odtFileReference := self markdownToODT: markdownFileReference.
	^ self odtToPDF: odtFileReference.