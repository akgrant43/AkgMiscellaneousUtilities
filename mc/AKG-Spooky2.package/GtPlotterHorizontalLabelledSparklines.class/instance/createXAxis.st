private
createXAxis
	| tickLabelLook tickLabelColor |

	tickLabelLook := [ BrGlamorousLabelLook new glamorousRegularFontAndSize ] asStencil.
	tickLabelColor := Color gray.
	^ GtPlotterHorizontalTickLabelsElement new
		clipChildren: false;
		scale: xAxisScale;
		"padding: (BlInsets left: self barLabelWidth + self gridlineOffset);"
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 50 ];
		labelFormat: [ :aTickObject | aTickObject printString ];
		labelElement: [ :aGtPlotterScaleContext |
			BrLabel new
				look: (tickLabelLook create foreground: tickLabelColor);
				text: (aGtPlotterScaleContext scale formattedTick: aGtPlotterScaleContext originalValue) ];
		labels: 3