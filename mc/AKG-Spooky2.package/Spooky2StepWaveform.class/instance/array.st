private
array 
	| yIncrement yValues xIncrement array i |

	yIncrement := 1024 / (steps-1).
	yValues := Array streamContents: [ :stream |
		stream nextPut: 0.
		1 to: (steps - 2) do: [ :step |
			stream nextPut: (yIncrement * step) rounded ].
		stream nextPut: 1023 ].
	xIncrement := (1024 / steps) rounded.
	i := 0.
	array := Array streamContents: [ :stream |
		1 to: steps do: [ :step |
			xIncrement timesRepeat: 
				[ stream nextPut: (yValues at: step).
				i := i + 1 ] ].
		i to: 1023 do: [ :x |
			array nextPut: 1023 ] ].
	^ array