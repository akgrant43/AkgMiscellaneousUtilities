private
array 
	| array |

	array := Array new: 1024.
	1 to: 1024 do: [ :i |
		array at: i put: i-1 ].
	up ifFalse: [ array := array reverse ].
	^ array