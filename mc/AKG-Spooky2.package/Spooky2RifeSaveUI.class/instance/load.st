private
load 
	| filename jsonObject |

	self acceptInput.
	filename := name text.
	filename ifEmpty: [ self error: 'Invalid filename' ].
	filename string asFileReference readStreamDo: [ :stream |
		jsonObject := (STON fromString: stream contents) ].
	model c1FunctionString: (jsonObject at: #c1Function).
	model c2FunctionString: (jsonObject at: #c2Function).
	model runTime: (jsonObject at: #runTime) asNumber.
	model description: ''.
	jsonObject at: #description ifPresent: [ :desc |
		model description: desc ].