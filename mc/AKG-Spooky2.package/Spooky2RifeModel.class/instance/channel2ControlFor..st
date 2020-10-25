ui
channel2ControlFor: aView
	<gtView>

	^ aView forward 
		title: self channelModels second label;
		priority: 30;
		object: [ self channelModels second ];
		view: #channelControlFor:.