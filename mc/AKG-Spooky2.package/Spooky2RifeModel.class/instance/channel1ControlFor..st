ui
channel1ControlFor: aView
	<gtView>

	^ aView forward 
		title: self channelModels first label;
		priority: 20;
		object: [ self channelModels first ];
		view: #channelControlFor:.