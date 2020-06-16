ui
channel1ControlFor: aView
	<gtView>

	^ aView forward 
		title: 'Channel 1';
		priority: 20;
		object: [ self channelModels first ];
		view: #channelControlFor:.