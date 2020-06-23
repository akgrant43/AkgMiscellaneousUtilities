accessing
runTime
	"Answer the time to be plotted"
	<return: #Duration>

	^ runTime ifNil: [ runTime := programme duration rounded seconds ]