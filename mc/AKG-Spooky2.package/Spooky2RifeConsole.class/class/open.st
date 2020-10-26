instance creation
open
	| console space |

	console := self new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		rifeModel: Spooky2RifeModel new;
		yourself.
	space := BlSpace new.
	space root addChild: console.
	space show.
	^ console rifeModel