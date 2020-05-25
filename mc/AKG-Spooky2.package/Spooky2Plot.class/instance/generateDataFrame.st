private
generateDataFrame
	| maxDuration rows |

	maxDuration := model c1Function duration max: model c2Function duration.
	rows := Array streamContents: [ :stream |
		1 to: maxDuration do: [ :t |
			stream nextPut: { 
				model c1Function value: t.
				model c2Function value: t. } ] ].
	^ DataFrame withRows: rows.
