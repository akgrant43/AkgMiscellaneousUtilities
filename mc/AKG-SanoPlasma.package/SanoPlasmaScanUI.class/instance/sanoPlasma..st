accessing
sanoPlasma: aSanoPlasma
	sanoPlasma := aSanoPlasma.
	self scanDirectory: (SanoPlasmaScanDirectory on: sanoPlasma).