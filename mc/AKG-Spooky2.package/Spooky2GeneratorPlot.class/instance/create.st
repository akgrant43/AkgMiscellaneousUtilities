accessing
create 

	^ Spooky2TimePlotElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		plotStencil: self;
		yourself.
