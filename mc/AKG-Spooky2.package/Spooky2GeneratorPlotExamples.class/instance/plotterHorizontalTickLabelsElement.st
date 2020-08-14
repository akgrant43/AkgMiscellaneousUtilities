as yet unclassified
plotterHorizontalTickLabelsElement
	| barWidthScale aMaxDuration tickLabelLook tickLabelColor |

	aMaxDuration := 30 minutes.
	tickLabelLook := [ BrGlamorousLabelLook new glamorousRegularFontAndSize ] asStencil.
	tickLabelColor := Color gray.
	"barWidthScale := GtPlotterDurationScale new domainFrom: 0 minutes to: aMaxDuration."
	barWidthScale := GtPlotterLinearScale new.
	barWidthScale domainFrom: 0 to: 30.
	^ GtPlotterHorizontalTickLabelsElement new
		clipChildren: false;
		scale: barWidthScale;
		"padding: (BlInsets left: self barLabelWidth + self gridlineOffset);"
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		labelFormat: [ :aTickObject | aTickObject printString ];
		labelElement: [ :aGtPlotterScaleContext |
			BrLabel new
				look: (tickLabelLook create foreground: tickLabelColor);
				text: (aGtPlotterScaleContext scale formattedTick: aGtPlotterScaleContext originalValue) ];
		labels: 3