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


 
Internal Representation and Key Implementation Points.

    Instance Variables
	endFreq:		<Object>
	freqRange:		<Object>
	outDir:		<Object>
	startFreq:		<Object>
	stepFreq:		<Object>


    Implementation Points