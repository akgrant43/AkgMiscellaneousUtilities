accessing
default
	"Find the location of an installation and answer a new instance pointing to it"

	| rootDir exportDir |

	rootDir := #(
		'/tmp/Spooky2'
		'/media/alistair/danielka/share/SanoPlasma/akg/Spooky2'
		'/home/alistair/tmp/Spooky2'
		'C:\Spooky2'
		) detect: [ :each | each asFileReference isDirectory ].
	exportDir := #(
		'/media/alistair/danielka/share/SanoPlasma'
		'/home/alistair/tmp/Spooky2'
		'E:\'
		) detect: [ :each | each asFileReference isDirectory ].
	^self new
		rootDirectory: rootDir asFileReference;
		exportDirectory: exportDir;
		yourself.