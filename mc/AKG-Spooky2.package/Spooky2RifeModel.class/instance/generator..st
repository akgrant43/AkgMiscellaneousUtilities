accessing
generator: aSignalGenerator

	generator := aSignalGenerator.
	channelModels do: [ :channel | channel generator: aSignalGenerator ]