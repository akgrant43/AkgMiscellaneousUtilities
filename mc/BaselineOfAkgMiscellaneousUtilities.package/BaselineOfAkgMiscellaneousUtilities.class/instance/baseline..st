baseline
baseline: spec
	<baseline>

	| packages |

	packages := Array streamContents: [ :stream |
		stream 
			nextPut: #'AKG-AST-Extensions';
			nextPut: #'AKG-AsciiFilename';
			nextPut: #'AKG-CodeAnalysis';
			nextPut: #'AKG-HashDeep';
			nextPut: #'AKG-PharoDotOrg';
			nextPut: #'AKG-Printing'.
		].
	spec for: #common do: [ spec 
		baseline: 'Diacritics' with: 
			[ spec repository: 'github://hernanmd/Diacriticals' ].

		packages do: [ :package |
			spec package: package ].

		spec		
			group: 'default' with: packages;
			group: 'tests' with: #('AKG-AsciiFilename-Tests');
			group: 'development' with: #('default' 'tests')
		]