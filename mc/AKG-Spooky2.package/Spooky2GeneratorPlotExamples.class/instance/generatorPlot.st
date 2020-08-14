examples
generatorPlot
	<gtExample>
	| rifeModel generatorPlot |

	rifeModel := self rifeModel.
	generatorPlot := Spooky2GeneratorPlot new 
							rifeModel: rifeModel.

	^ generatorPlot