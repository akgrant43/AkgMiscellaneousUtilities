initialization
initialize

	super initialize.
	valueHolder := NewValueHolder new value: 0.
	startValue := -1.
	endValue := 1.

	self regeneratePlot.

	self 
		when: BlClickEvent
		do: [ :event | self processClickEvent: event ].