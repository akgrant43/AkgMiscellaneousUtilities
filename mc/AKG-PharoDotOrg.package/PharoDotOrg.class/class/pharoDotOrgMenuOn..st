world menu
pharoDotOrgMenuOn: aBuilder
	<worldMenu>

	(aBuilder item: #AKG) with: [ 
		(aBuilder item: 'Pharo.org')
			parent: #AKG;
			action: [ [ PharoDotOrg new inspect ] forkAt: 20 ] ]