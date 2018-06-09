history
dj20180609
	"DJ: Up and Down sets.
	- 1Hz - 1kHz, 100Hz range, 10Hz step
	- 30 minute duration
	- No wobble
	- Repeat each program 3 times
	- Crossover at 50Hz mark
	- Offset 2 0%"
	<script>

	| generator settings |

	generator := self new
		startFreq: 0;
		endFreq: 900;
		stepFreq: 50;
		freqRange: 100;
		crossoverCount: 10;
		crossoverRange: 10;
		programSeconds: 1800;
		namePrefix: 'Fr';
		namePostfix: '';
		outDir: '/dev/shm/sanoplasma/Step 100Hz Cross 10 30min Up';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '1'.
	generator generate.


	generator := self new
		startFreq: 100;
		endFreq: 1000;
		stepFreq: 50;
		freqRange: -100;
		programSeconds: 1800;
		crossoverCount: 10;
		crossoverRange: 10;
		namePrefix: 'Fr';
		namePostfix: 'down';
		outDir: '/dev/shm/sanoplasma/Step 100Hz Cross 10 30min Down';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '1'.
	generator generate.
