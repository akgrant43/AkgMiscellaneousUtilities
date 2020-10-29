private
stepSize
	"Answer the duration to step, currently 1% of the smaller channel duration"

	^ ((channelModels first duration min: channelModels second duration) / 100) rounded seconds.