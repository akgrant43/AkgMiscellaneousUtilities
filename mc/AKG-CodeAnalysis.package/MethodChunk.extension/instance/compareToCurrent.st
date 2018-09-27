*AKG-CodeAnalysis
compareToCurrent

	| class sourceString |
	class := self targetClass.
	sourceString := (class >> self methodSelector) sourceCode.
	UIManager default
		openComparisonFrom: self contents
		to: sourceString
		belongingTo: class
		from: self
		labeled: 'Current'
		inWindowLabeled: 'Comparison to Current Version'