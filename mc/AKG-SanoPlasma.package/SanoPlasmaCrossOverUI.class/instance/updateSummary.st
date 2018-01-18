private
updateSummary
	"Update the summary text"

	| newText |

	newText := String streamContents: [ :stream |
		stream
			<< 'Crossover Freq. (kHz):'; tab; tab;
			<< self crossoverFrequency asString; cr;
			<< 'Range (Hz):'; tab; tab; tab; tab;
			<< self range asString; cr;
			<< 'Time (min):'; tab; tab; tab; tab;
			<< self timeInMinutes asString; cr;
			<< 'Name:'; tab; tab; tab; tab; tab;
			<< self name asString; cr;
			cr;
			<< 'Frequency Range (kHz): '; tab;
			<< self frequencyRangeString asString; cr; cr.
		self validConfiguration 
			ifTrue: [ stream << 'Configuration Valid' ]
			ifFalse: [ stream << 'Invalid Configuration' ].
		stream cr ].
		summaryText text: newText