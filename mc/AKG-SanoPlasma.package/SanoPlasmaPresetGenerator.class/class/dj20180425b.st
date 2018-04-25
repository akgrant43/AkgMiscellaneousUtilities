history
dj20180425b
	"DJ: Up and Down sets.
	- 30 minute duration
	- No wobble
	- Repeat each program 3 times
	- Out 2 Offset 100%
	- Crossover at 100Hz mark (instead of 50Hz)"
	<script>

	| generator settings |

	generator := self new
		startFreq: 1050;
		endFreq: 899500;
		stepFreq: 500;
		freqRange: 1000;
		crossoverCount: 10;
		crossoverRange: 100;
		programSeconds: 1800;
		namePrefix: 'Fr';
		namePostfix: '';
		outDir: '/dev/shm/sanoplasma/Step 1kHz Cross 10-100Hz Offset2 100 30min Up';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Offset' put: '100';
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '1'.
	generator generate.


	generator := self new
		startFreq: 2050;
		endFreq: 899500;
		stepFreq: 500;
		freqRange: -1000;
		programSeconds: 1800;
		crossoverCount: 10;
		crossoverRange: 100;
		namePrefix: 'Fr';
		namePostfix: 'down';
		outDir: '/dev/shm/sanoplasma/Step 1kHz Cross 10-100Hz Offset2 100 30min Down';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Offset' put: '100';
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '1'.
	generator generate.

