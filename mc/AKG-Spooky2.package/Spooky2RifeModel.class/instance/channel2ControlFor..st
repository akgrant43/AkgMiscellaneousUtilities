ui
channel2ControlFor: aView
	<gtView>

	^ aView forward 
		title: 'Channel 2';
		priority: 20;
		object: [ self channelModels second ];
		view: #channelControlFor:.