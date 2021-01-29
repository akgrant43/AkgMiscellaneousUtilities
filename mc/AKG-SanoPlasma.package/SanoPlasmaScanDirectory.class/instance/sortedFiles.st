private
sortedFiles
	"Answer the receivers list of reports and directories"
	| files |

	files := self directory files select: [ :each | 
		(each basename endsWith: '.csv') and:
		[ (SanoPlasmaScanResults on: each sanoPlasma: sanoPlasma) scanData isNotNil ] ].
	files := files sorted: [ :a :b |
		a creationTime > b creationTime ].
	^ files