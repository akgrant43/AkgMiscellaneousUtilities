baselines
baseline: spec 
	<baseline>

	spec for: #common do: [ 
		spec blessing: #baseline.

		"spec baseline: 'Roassal2' with:
			[ spec repository: 'github://ObjectProfile/Roassal2/src' ]."

		spec package: 'AKG-Spooky2' "with: 
			[ spec requires: #('Roassal2') ]" .
		spec 
			group: #'Core' with: #('AKG-Spooky2');
			group: #'default' with: #('Core').
 ]