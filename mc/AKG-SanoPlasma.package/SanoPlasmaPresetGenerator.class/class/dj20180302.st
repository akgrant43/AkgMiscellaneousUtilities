history
dj20180302
	<script>

	| generator settings |

	generator := self new
		startFreq: 2000;
		endFreq: 899500;
		stepFreq: 500;
		freqRange: -1000;
		programSeconds: 1200;
		namePrefix: 'Fr';
		namePostfix: 'down';
		outDir: '/dev/shm/sanoplasma/down';
		yourself.
	settings := generator settings.
	settings
		at: 'Out 2 Voltage Multiplier' put: '3'.
	generator generate.