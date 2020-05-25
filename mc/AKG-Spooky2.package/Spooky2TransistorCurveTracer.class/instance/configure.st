configuration
configure

	generator connect.
	generator writeCommand: ((Spooky2RampWaveform new) commandForNumber: 1).
	generator writeCommand: ((Spooky2StepWaveform new steps: steps) commandForNumber: 2).
	generator channel: 1 arbitraryWave: 1.
	generator channel: 2 arbitraryWave: 2.
	generator channel: 1 frequency: stepFrequency * steps + 0.03.
	generator channel: 2 frequency: stepFrequency.
	generator channel: 1 amplitude: amplitude1.
	generator channel: 1 offset: 200.
	generator channel: 2 amplitude: amplitude2.
	generator channel: 2 offset: 200.
	generator close.