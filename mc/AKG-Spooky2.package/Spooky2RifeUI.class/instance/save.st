private
save 
	| filename jsonObject |

	self acceptInput.
	filename := name text.
	filename ifEmpty: [ self error: 'Invalid filename' ].
	jsonObject := { 
		'c1Function' -> c1Function text string.
		'c2Function' -> c2Function text string.
		'runTime' -> runTime text string.
		'description' -> description text string. } asDictionary.
	filename string asFileReference writeStreamDo: [ :stream |
		stream << (STON toJsonStringPretty: jsonObject) ].