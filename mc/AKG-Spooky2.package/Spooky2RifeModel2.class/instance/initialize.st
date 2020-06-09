initialization
initialize 

	super initialize.
	generator := Spooky2SignalGeneratorSimulator new connect.
	announcer := Announcer new.
	state := #stopped.
	functionStrings := { self defaultFunctionUp: true. self defaultFunctionUp: false. }.
	functions := Array new: 2.
	description := ''.
	runTime := 60 minutes.
	wobbles := { 0. 0. }.
	voltages := { 6. 5. }.
	times := Array new: 2.
	random := Random new.