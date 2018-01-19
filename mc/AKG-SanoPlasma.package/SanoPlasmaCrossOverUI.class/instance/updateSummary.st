private
updateSummary
	"Update the summary text"

	| newText configErrors o2V |

	self settings ifNil:
		[ o2V := 'N/A' ]
	ifNotNil: 
		[ o2V := settings output2Voltage asString ].
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
			<< 'Out 2 Voltage:'; tab; tab; tab;
			<< o2V; cr;
			cr;
			<< 'Frequency Range (kHz): '; tab;
			<< self frequencyRangeString asString; cr; cr.
		configErrors := self configurationErrors.
		configErrors isEmpty
			ifTrue: [ stream << 'Configuration Valid' ]
			ifFalse: [ 
				stream << 'Invalid Configuration:'; cr.
				configErrors do: [ :each |
					stream
						<< '- ';
						<< each;
						cr ] ].
		stream cr ].
		summaryText text: newText