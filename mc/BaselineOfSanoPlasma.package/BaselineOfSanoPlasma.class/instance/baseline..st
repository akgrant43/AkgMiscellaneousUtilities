baselines
baseline: spec
	<baseline>

	| corePackages |

	corePackages := #(
		#'AKG-SanoPlasma'
		).
	spec for: #common do: [ 
		spec blessing: #baseline.
		spec project: 'NeoCSV' with: [ 
			spec 
				className: #ConfigurationOfNeoCSV;
				versionString: #stable;
				repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo60/main' ].
		spec package: 'AKG-SanoPlasma' with: [ 
			spec requires: #('NeoCSV') ].
		spec
			group: 'Core' with: corePackages;
			group: 'all' with: #(#Core);
			group: 'default' with: #(#all).
		]