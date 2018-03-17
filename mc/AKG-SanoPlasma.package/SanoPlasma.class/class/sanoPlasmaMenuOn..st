world menu
sanoPlasmaMenuOn: aBuilder
	"Add the SanoPlasma world menu items"
	<worldMenu>

	| sanoPlasma |

	sanoPlasma := aBuilder item: #SanoPlasma.
	sanoPlasma with: [ 
		(aBuilder item: #Chains)
			parent: #SanoPlasma;
			action: [ SanoPlasma default openUI ].
		(aBuilder item: #ScanResults)
			parent: #SanoPlasma;
			action: [ SanoPlasma default openScanUI ].
		(aBuilder item: #CrossOverUI)
			parent: #SanoPlasma;
			action: [ SanoPlasma default openCrossOverUI ] ]