history
dj20180305
	"DJ: Up and Down sets.
	- Leave up out of preset name
	- 20 minute duration
	- No wobble
	- Repeat each program 3 times"
	<script>

	| generator settings |

	generator := self new
		startFreq: 1000;
		endFreq: 899500;
		stepFreq: 500;
		freqRange: 1000;
		programSeconds: 1200;
		namePrefix: 'Fr';
		namePostfix: '';
		outDir: '/dev/shm/sanoplasma/Step 1kHz 20min Up';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '3'.
	generator generate.


	generator := self new
		startFreq: 2000;
		endFreq: 899500;
		stepFreq: 500;
		freqRange: -1000;
		programSeconds: 1200;
		namePrefix: 'Fr';
		namePostfix: 'down';
		outDir: '/dev/shm/sanoplasma/Step 1kHz 20min Down';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Voltage Multiplier' put: '3';
		at: 'Repeat each program' put: '3'.
	generator generate.

