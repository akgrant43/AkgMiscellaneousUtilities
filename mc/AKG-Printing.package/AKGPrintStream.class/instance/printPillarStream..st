actions
printPillarStream: aStream
	"Print the supplied stream"

	self 
		pillarToMarkdown: aStream;
		markdownToPDF;
		printPDF.