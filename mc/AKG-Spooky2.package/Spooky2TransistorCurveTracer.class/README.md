Configure the Spooky2 signal generator to output the waveforms to use as a Transistor Curve Tracer with an oscilloscope.

- steps are the number of curves to trace, default = 4.
- stepFrequency is the frequency to complete the number of configured steps.
- amplitude1 & 2 is the voltage output of each channel.

The drift will be individual to each generator.  Currently hard-coded to 0.03Hz (see #configure).

Connect the signal generator, then:

[[[ 
Spooky2TransistorCurveTracer new configure 
]]]

Start and stop the generator with the OK button on the unit.

!!Internal Representation and Key Implementation Points.

!!!Instance Variables
	amplitude1:		<Integer>
	amplitude2:		<Integer>
	generator:		<Spooky2SignalGenerator>
	stepFrequency:	<Integer>
	steps:				<Integer>


!!!Implementation Points

- Drift is hard coded and should be an instance variable.