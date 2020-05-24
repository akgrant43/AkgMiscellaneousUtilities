private
save 
	| filename jsonObject |

	self acceptInput.
	filename := name text.
	filename ifEmpty: [ self error: 'Invalid filename' ].
	jsonObject := { 
		'c1Function' -> model c1FunctionString.
		'c2Function' -> model c2FunctionString.
		'runTime' -> model runTime.
		'description' -> model description.
		'wobbleAmount' -> model wobble. } asDictionary.
	filename string asFileReference writeStreamDo: [ :stream |
		stream << (STON toJsonStringPretty: jsonObject) ].