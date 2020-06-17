ui
channel2ControlFor: aView
	<gtView>

	^ aView forward 
		title: 'Channel 2';
		priority: 30;
		object: [ self channelModels second ];
		view: #channelControlFor:.