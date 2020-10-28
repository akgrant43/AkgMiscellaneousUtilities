initialize
initialize

	super initialize.
	self 
		when: BlClickEvent
		do: [ :event | self processClickEvent: event ]