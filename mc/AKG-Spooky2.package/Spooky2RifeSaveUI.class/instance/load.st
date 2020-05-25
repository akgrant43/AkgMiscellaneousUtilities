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
		desc ifNotNil: [ model description: desc ] ].
	jsonObject at: #wobbleAmount ifPresent: [ :wobble |
		model wobble: wobble. ].
	jsonObject at: #zapperVoltage ifPresent: [ :voltage |
		model c2Voltage: voltage. ].
	model announcer announce: Spooky2Loaded new.