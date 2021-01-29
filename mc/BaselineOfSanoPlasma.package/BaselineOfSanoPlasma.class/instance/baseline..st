baselines
baseline: spec
	<baseline>

	| corePackages |

	corePackages := #(
		#'AKG-SanoPlasma'
		).
	spec for: #common do: [ 
		spec blessing: #baseline.
		spec baseline: 'AkgMiscellaneousUtilities' with: [ 
			spec repository: 'github://akgrant43/AkgMiscellaneousUtilities/mc' ].
		spec baseline: 'NeoCSV' with: [ 
			spec repository: 'github://svenvc/NeoCSV/repository' ].
		spec baseline: 'DataFrame' with: [ 
			spec repository: 'github://PolyMathOrg/DataFrame' ].
		spec package: 'AKG-SanoPlasma' with: [ 
			spec requires: #('NeoCSV' 'DataFrame' 'AkgMiscellaneousUtilities') ].
		spec
			group: 'Core' with: corePackages;
			group: 'all' with: #(#Core);
			group: 'default' with: #(#all).
		]