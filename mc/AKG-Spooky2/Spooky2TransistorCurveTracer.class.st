"
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
"
Class {
	#name : #Spooky2TransistorCurveTracer,
	#superclass : #Object,
	#instVars : [
		'generator',
		'steps',
		'stepFrequency',
		'amplitude1',
		'amplitude2'
	],
	#category : 'AKG-Spooky2-Utilities'
}

{ #category : #accessing }
Spooky2TransistorCurveTracer >> amplitude1 [
	^ amplitude1
]

{ #category : #accessing }
Spooky2TransistorCurveTracer >> amplitude1: anObject [
	amplitude1 := anObject
]

{ #category : #accessing }
Spooky2TransistorCurveTracer >> amplitude2 [
	^ amplitude2
]

{ #category : #accessing }
Spooky2TransistorCurveTracer >> amplitude2: anObject [
	amplitude2 := anObject
]

{ #category : #configuration }
Spooky2TransistorCurveTracer >> configure [

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
]

{ #category : #accessing }
Spooky2TransistorCurveTracer >> generator [
	^ generator
]

{ #category : #initialization }
Spooky2TransistorCurveTracer >> initialize [ 

	super initialize.
	generator := Spooky2SignalGenerator new.
	steps := 4.
	stepFrequency := 200.
	amplitude1 := 2.
	amplitude2 := 2.
]

{ #category : #accessing }
Spooky2TransistorCurveTracer >> stepFrequency [
	^ stepFrequency
]

{ #category : #accessing }
Spooky2TransistorCurveTracer >> stepFrequency: anObject [
	stepFrequency := anObject
]

{ #category : #accessing }
Spooky2TransistorCurveTracer >> steps [
	^ steps
]

{ #category : #accessing }
Spooky2TransistorCurveTracer >> steps: anObject [
	steps := anObject
]
