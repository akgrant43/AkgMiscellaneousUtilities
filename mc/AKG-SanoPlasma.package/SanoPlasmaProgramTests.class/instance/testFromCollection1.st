tests
testFromCollection1

	| program name time notes frequencies organ illness dwell |

	name := 'Name1'.
	time := '123'.
	notes := 'Note1'.
	frequencies := '1,2,3'.
	organ := nil.
	illness := nil.
	dwell := '321'.
	program := SanoPlasmaProgram fromCollection: { 
		name. 'CUST'. time. notes. frequencies. organ. illness. dwell. }.
	self assert: program name equals: name.
	self assert: program runningTime equals: time asNumber.
	self assert: program notes equals: notes.
	self assert: program dwell equals: dwell asNumber.
	self assert: program frequencies size equals: 3.