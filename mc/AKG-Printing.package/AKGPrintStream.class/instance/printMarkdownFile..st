printing
printMarkdownFile: aFileReference
	"Print the supplied markdown file"

	self markdownToPDF: aFileReference.
	self printPDF: self pdfTemporary.