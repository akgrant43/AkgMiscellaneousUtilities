private
load 
	| filename jsonObject |

	self acceptInput.
	filename := name text.
	filename ifEmpty: [ self error: 'Invalid filename' ].
	filename string asFileReference readStreamDo: [ :stream |
		jsonObject := (STON fromString: stream contents) ].
	c1Function text: (jsonObject at: #c1Function) asText.
	c2Function text: (jsonObject at: #c2Function) asText.
	runTime text: (jsonObject at: #runTime) asText.
	jsonObject at: #description ifPresent: [ :desc |
		description text: desc asText ].