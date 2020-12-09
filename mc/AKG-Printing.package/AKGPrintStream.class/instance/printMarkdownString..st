printing
printMarkdownString: aString
	| pdfFile |

	pdfFile := self markdownStringToPDF: aString.
	self printPDF: pdfFile.