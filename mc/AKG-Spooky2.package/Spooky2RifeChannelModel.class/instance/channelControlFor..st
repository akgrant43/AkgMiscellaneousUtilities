ui
channelControlFor: aView
	<gtView>

	^aView explicit 
		title: 'Channel ', channelNumber asString;
		priority: 20;
		stencil: [ Spooky2RifeChannelElement new rifeModel: self; configure ].