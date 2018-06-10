actions
printStream: aStream
	"Print the supplied stream"

	self 
		writeToText: aStream;
		convertToPDF;
		printPDF.