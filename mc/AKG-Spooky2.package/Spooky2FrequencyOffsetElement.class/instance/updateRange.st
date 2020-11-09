private
updateRange

	[ range := maxFrequencyInput editor text asString. 
	(NumberParser isNumber: range) ifTrue:
		[ range := range asNumber.
		sliderElement 
			startValue: 0 - range;
			endValue: range;
			regeneratePlot.
		maxFrequencyInput background: (Color fromHexString: #'f0f0f0').
		sliderElement valueHolder value: 0.5 ]
	ifFalse:
		[ StringSignal emit: 'phooey 2'.
		maxFrequencyInput background: (Color fromHexString: #'f00000'). ] ]
		on: Error 
		do: [ :ex | StringSignal emit: 'phooey'.
			maxFrequencyInput background: (Color fromHexString: #'f00000').
			maxFrequencyInput invalidate ].
