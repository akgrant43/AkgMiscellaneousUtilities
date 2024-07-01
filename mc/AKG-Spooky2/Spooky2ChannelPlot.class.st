Class {
	#name : #Spooky2ChannelPlot,
	#superclass : #BrStencil,
	#instVars : [
		'rifeModel',
		'programme',
		'sparkleStencil',
		'offset',
		'channelNumber'
	],
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #'private - accessing' }
Spooky2ChannelPlot >> channelModel [

	^ rifeModel channelModels at: channelNumber
]

{ #category : #accessing }
Spooky2ChannelPlot >> channelNumber [
	^ channelNumber ifNil: [ 1 ]
]

{ #category : #accessing }
Spooky2ChannelPlot >> channelNumber: anObject [
	channelNumber := anObject
]

{ #category : #'api - instantiation' }
Spooky2ChannelPlot >> create [ 

	^ self sparkleStencil create
]

{ #category : #accessing }
Spooky2ChannelPlot >> data [
	"Answer the data structure used by the sparkle line"

	^ GtPlotterDataGroup new
		values: self points;
		colored: self plotColor.

]

{ #category : #initialization }
Spooky2ChannelPlot >> initialize [

	super initialize.
	offset := 0.
]

{ #category : #accessing }
Spooky2ChannelPlot >> maxFrequency [

	^ rifeModel maxFrequency
]

{ #category : #accessing }
Spooky2ChannelPlot >> minFrequency [

	^ rifeModel minFrequency
]

{ #category : #accessing }
Spooky2ChannelPlot >> offset [
	^ offset
]

{ #category : #accessing }
Spooky2ChannelPlot >> offset: anObject [
	offset := anObject
]

{ #category : #'private - accessing' }
Spooky2ChannelPlot >> plotColor [
	"Answer the colour to be used for the plot"

	^ (rifeModel channelModels at: channelNumber) suggestedColor.
]

{ #category : #accessing }
Spooky2ChannelPlot >> points [
	"Answer the collection of points to be plotted"
	| timeOffset |

	timeOffset := self channelModel timeOffset asSeconds.
	^ (1 to: self xPointCount) collect: [ :x |
		x @ ((self channelModel valueAt: (x + timeOffset)) + offset) ].

]

{ #category : #accessing }
Spooky2ChannelPlot >> programme [
	^ programme
]

{ #category : #accessing }
Spooky2ChannelPlot >> programme: anObject [
	programme := anObject
]

{ #category : #accessing }
Spooky2ChannelPlot >> rifeModel [
	^ rifeModel
]

{ #category : #accessing }
Spooky2ChannelPlot >> rifeModel: anObject [
	rifeModel := anObject
]

{ #category : #accessing }
Spooky2ChannelPlot >> runTime [
	"Answer the time to be plotted"
	<return: #Duration>

	^ rifeModel runTime
]

{ #category : #accessing }
Spooky2ChannelPlot >> sparkleStencil [

	^ GtPlotterHorizontalSparkline new
		scaleX: (GtPlotterLinearScale new domainFrom: 0 to: self xPointCount);
		scaleDataX: #x;
		scaleY: (GtPlotterLinearScale new domainFrom: self minFrequency to: self maxFrequency);
		scaleDataY: #y;
		with: self data
]

{ #category : #accessing }
Spooky2ChannelPlot >> xPointCount [
	"Answer the number of points on the x-axis.
	= the duration in seconds"

	^ self runTime asSeconds rounded
]
