actions
printTextStream: aStream
	"Print the supplied stream, converting to postscript using enscript and then to pdf with ps2pdf"

	self 
		writeToText: aStream;
		enscriptToPDF;
		printPDF: self pdfTemporary.