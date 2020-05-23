private
findPort
	"Search /dev for ttyUSB* and assume that that is the meter."

	| candidates |

	OSPlatform current name = #Win32 ifTrue: [ ^ 'COM3:' ].

	candidates := '/dev' asFileReference entries select: 
			[ :each | each fullName beginsWith: '/dev/ttyUSB' ].
	candidates size = 1 ifFalse:
		[ self error: 'Expected a single usb device, found ', candidates size asString ].
	^ candidates first fullName