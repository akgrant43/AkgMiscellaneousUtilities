baseline
baseline: spec
	<baseline>
	spec for: #common do: [ spec 
		configuration: 'Diacritics' with: [ spec 
			versionString: #stable;
			repository: 'http://smalltalkhub.com/mc/herman/Diacritics/main' ];

		package: 'AKG-AsciiFilename';
		
		group: 'default' with: #('AKG-AsciiFilename');
		group: 'tests' with: #('AKG-AsciiFilename-Tests');
		group: 'development' with: #('default' 'tests')
		]