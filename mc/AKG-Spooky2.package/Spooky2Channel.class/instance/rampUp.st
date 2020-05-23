accessing - wave forms
rampUp
	| values |

	values := Array new: 1024.
	1 to: 1023 do: [ :i |
		values at: i put: i-1 ].
	values at: 1024 put: 0.
	self pWaveform: 1 values: values.
	self arbitraryWave: 1.