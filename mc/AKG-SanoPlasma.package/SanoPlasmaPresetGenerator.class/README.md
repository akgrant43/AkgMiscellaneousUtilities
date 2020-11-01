SanoPlasmaPresetGenerator generates a custom.csv (custom programs) and presets for running the plasma and contacts in crossover fashion, i.e. the plasma runs from the start frequence to the end frequency, and the contacts run in the opposite direction.

The custom programs are not required to use the presets.

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

The stepFreq is the increase in frequency (Hz) between each preset, e.g. in the above example the first preset will start at 400KHz, the second at 400.5kHz.

It is possible to generate programs where the plasma frequency range runs from high-to-low, e.g.:

SanoPlasmaPresetGenerator new
	startFreq: 2000;
	endFreq: 899500;
	stepFreq: 500;
	freqRange: -1000;
	programSeconds: 1200;
	namePrefix: 'Fr';
	namePostfix: 'down';
	outDir: '/dev/shm/sanoplasma';
	generate

The number of crossovers per program can also be specified with the crossoverCount and crossoverRange:

startFreq = 1000
freqRange = 1000
crossoverCount = 20
crossoverRange = 100

There will be 10 crossovers per chain, each running for 100 Hz.

| generator |
generator := SanoPlasmaPresetGenerator new
	startFreq: 1000;
	endFreq: 899000;
	stepFreq: 500;
	freqRange: 1000;
	crossoverCount: 20;
	crossoverRange: 100;
	programSeconds: 3000;
	namePrefix: 'Fr';
	outDir: '/dev/shm/sanoplasma/Step 1kHz Cross 20-100 50min Up';
	yourself.
generator settings
	at: 'Out 2 Voltage Multiplier' put: '3';
	at: 'Repeat each program' put: '3'.
generator generate.


A start or end frequency of 0 will be converted to 1 in the program, i.e. specifying 0 - 1000Hz will actually generate 1 - 1000Hz.
 
Internal Representation and Key Implementation Points.

Instance Variables
	startFreq:		<Integer>	Start frequency, must be positive
	endFreq:			<Integer> End frequency, must be positive
	freqRange:		<Integer> Frequency range for each chain.  Can be negative.
	programSeconds 	<Integer> The total number of seconds for the chain.
							i.e. each preset runs for programSeconds / crossoverCount
	crossoverCount: <Integer> Number of crossovers for each chain.  Default = 1.
	stepFreq:			<Integer> Frequency step amount for each chain.
	outDir:			<String>


Implementation Points