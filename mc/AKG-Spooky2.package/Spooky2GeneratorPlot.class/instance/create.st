accessing
create 
	| c1Element c2Element container |

	c1Element := self channel1Plot create.
	c2Element := self channel2Plot create.

	container := BlElement new 
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent. ].
	container 
		addChild: c1Element;
		addChild: c2Element.

	^ container