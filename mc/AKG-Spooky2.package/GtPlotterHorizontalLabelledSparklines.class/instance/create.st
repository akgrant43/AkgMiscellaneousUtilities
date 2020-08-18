api - instantiation
create 
	| plotAndXAxis plotArea |

	plotArea := BlElement new 
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent. ].
	plotArea addChild: self plotGrid.
	plotArea addChildren: (sparklines collect: [ :each | 
		each create
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent. ] ]).

	plotAndXAxis := BlElement new 
		layout: BlLinearLayout vertical;
		clipChildren: false;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent. ].

	plotAndXAxis
		addChild: plotArea;
		addChild: self createXAxis.

	^ plotAndXAxis