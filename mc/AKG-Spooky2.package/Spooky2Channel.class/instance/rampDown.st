accessing - wave forms
rampDown
	| values |

	values := Array new: 1024.
	1 to: 1023 do: [ :i |
		values at: i put: 1023-i ].
	values at: 1024 put: 1022.
	self pWaveform: 2 values: values.
	self arbitraryWave: 2.