api - instantiation
create 
	| container |

	container := BlElement new 
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent. ].

	container addChildren: (sparklines collect: [ :each | each create ]).

	^ container