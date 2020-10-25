[[[
console := Spooky2RifeConsole new 
	constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ];
	rifeModel: Spooky2RifeModel new;
 	yourself.
BlSpace new
	root: console;
	open.
]]]
 
Internal Representation and Key Implementation Points.


    Implementation Points