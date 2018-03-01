SanoPlasmaPresetGenerator generates a custom.csv (custom programs) and presets for running the plasma and contacts in crossover fashion, i.e. the plasma runs from the start frequence to the end frequency, and the contacts run in the opposite direction.

SanoPlasmaPresetGenerator new
	startFreq: 400000;
	endFreq: 500000;
	stepFreq: 500;
	freqRange: 1000;
	programSeconds: 1800;
	namePrefix: 'Fr';
	outDir: '/dev/shm/sanoplasma';
	generate


By default, and as in the example above, the program frequency range for the plasma runs from low-to-high, and the contact frequency range runs from high-to-low.

It is possible to generate programs where the plasma frequency range runs from high-to-low, e.g.:

SanoPlasmaPresetGenerator new
	startFreq: 100000;
	endFreq: 899500;
	stepFreq: 500;
	freqRange: -1000;
	programSeconds: 1200;
	namePrefix: 'Fr';
	namePostfix: 'down';
	outDir: '/dev/shm/sanoplasma';
	generate

 
Internal Representation and Key Implementation Points.

Instance Variables
	startFreq:		<Integer>	Start frequency, must be positive
	endFreq:			<Integer> End frequency, must be positive
	freqRange:		<Integer> Frequency range for each program.  Can be negative.
	stepFreq:			<Integer> Frequency step amount for each program.
	outDir:			<String>


Implementation Points