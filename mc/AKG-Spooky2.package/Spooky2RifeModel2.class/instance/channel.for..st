ui -private
channel: channelNumber for: aView

	^aView explicit 
		title: 'Channel ', channelNumber asString;
		priority: 20;
		stencil: [ self asElementForChannel: channelNumber ];
		actionButtonIcon: BrGlamorousIcons browse
			action: [ :anObject | self inspect ];
		actionButtonIcon: BrGlamorousIcons fromhere
			action: [ :anObject | anObject phlow spawnObject: self ].