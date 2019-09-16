actions
printPillarStream: aStream to: aFileReference
	"Print the supplied stream to the specified file in PDF format"

	self 
		pdfTemporary: aFileReference;
		pillarToMarkdown: aStream;
		markdownToPDF.