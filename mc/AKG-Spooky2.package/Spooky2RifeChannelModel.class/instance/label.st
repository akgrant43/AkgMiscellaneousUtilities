accessing
label
	^ label ifNil: [ 'Channel ', channelNumber asString ]