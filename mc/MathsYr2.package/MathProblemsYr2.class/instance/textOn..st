printing
textOn: aTextStream

	aTextStream
		nextPutAll: self printString;
		applyAttribute: (TextFontReference
					toFont: (LogicalFont 
						familyName: 'Source Code Pro' 
						pointSize: StandardFonts defaultFont pointSize)) beginningAt: 1.
	^aTextStream