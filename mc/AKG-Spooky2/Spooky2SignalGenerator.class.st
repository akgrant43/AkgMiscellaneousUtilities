Class {
	#name : #Spooky2SignalGenerator,
	#superclass : #Object,
	#instVars : [
		'channels',
		'deviceName',
		'serialPort',
		'writeSemaphore',
		'readProcess'
	],
	#category : 'AKG-Spooky2-Model'
}

{ #category : #private }
Spooky2SignalGenerator class >> findPort [
	"Search /dev for ttyUSB* and assume that that is the meter."

	| candidates |

	OSPlatform current name = #Win32 ifTrue: [ ^ 'COM3:' ].

	candidates := '/dev' asFileReference entries select: 
			[ :each | each fullName beginsWith: '/dev/ttyUSB' ].
	candidates size = 1 ifFalse: [ ^ nil ].
	^ candidates first fullName
]

{ #category : #accessing }
Spooky2SignalGenerator >> channel1 [
	^ channels first
]

{ #category : #accessing }
Spooky2SignalGenerator >> channel1: anObject [
	channels at: 1 put: anObject
]

{ #category : #accessing }
Spooky2SignalGenerator >> channel2 [
	^ channels second
]

{ #category : #accessing }
Spooky2SignalGenerator >> channel2: anObject [
	channels at: 2 put: anObject
]

{ #category : #accessing }
Spooky2SignalGenerator >> channel: channelNumber amplitude: aNumber [
	| channel |
	
	channel := channels at: channelNumber.
	channel amplitude: aNumber.
	self writeCommand: channel amplitudeCommand.
]

{ #category : #accessing }
Spooky2SignalGenerator >> channel: channelNumber arbitraryWave: aNumber [
	"Set the channel to the given arbitrary wave number"
	| channel |
	
	channel := channels at: channelNumber.
	channel arbitraryWave: aNumber.
	self writeCommand: channel waveformCommand.
]

{ #category : #accessing }
Spooky2SignalGenerator >> channel: channelNumber dutyCycle: aNumber [
	| channel |
	
	channel := channels at: channelNumber.
	channel dutyCycle: aNumber.
	self writeCommand: channel dutyCycleCommand.
]

{ #category : #accessing }
Spooky2SignalGenerator >> channel: channelNumber frequency: aNumber [
	| channel |
	
	channel := channels at: channelNumber.
	channel frequency: aNumber.
	self writeCommand: channel frequencyCommand.
]

{ #category : #accessing }
Spooky2SignalGenerator >> channel: channelNumber offset: aNumber [
	| channel |
	
	channel := channels at: channelNumber.
	channel offset: aNumber.
	self writeCommand: channel offsetCommand.
]

{ #category : #accessing }
Spooky2SignalGenerator >> channel: channelNumber phase: aNumber [
	| channel |
	
	channel := channels at: channelNumber.
	channel phase: aNumber.
	self writeCommand: channel phaseCommand.
]

{ #category : #accessing }
Spooky2SignalGenerator >> channelAt: aNumber [

	^ channels at: aNumber
]

{ #category : #'initialize-release' }
Spooky2SignalGenerator >> close [ 

	serialPort ifNotNil:
		[ serialPort close.
		readProcess ifNotNil: [ readProcess terminate. ].
		serialPort := nil.
		readProcess := nil. ].
]

{ #category : #actions }
Spooky2SignalGenerator >> connect [
	"Connect to the signal generator"

	self
		assert: serialPort isNil
		description: 'Already connected to the signal generator'.

	serialPort := SerialPort new 
		baudRate: 57600; 
		dataBits: 8; 
		stopBitsType: 1; 
		parityType: 0; 
		yourself. 
	serialPort close.
	[ 	serialPort openPort: self deviceName.
		self startReadProcess. ]
			on: Error 
			do: [ StringSignal emit: 'Unable to open serial port' ]
]

{ #category : #accessing }
Spooky2SignalGenerator >> deviceName [

	^ deviceName ifNil: 
		[ deviceName := self class findPort.
		deviceName ifNil: [ self error: 'Unable to find Spooky2 serial port' ].
		deviceName. ]
]

{ #category : #accessing }
Spooky2SignalGenerator >> deviceName: anObject [
	deviceName := anObject
]

{ #category : #initialization }
Spooky2SignalGenerator >> initialize [ 

	super initialize.
	writeSemaphore := Semaphore new signal.
	channels := { 
		Spooky2Channel new channel: 1.
		Spooky2Channel new channel: 2 }.

]

{ #category : #private }
Spooky2SignalGenerator >> processReadString: aString [
	| contents |

	contents := aString trimBoth.
	contents size > 0 ifTrue: 
		[ Stdio stdout << contents; lf.
		contents lines do: [ :line |
			line trimBoth = 'ok'
				ifTrue: [ writeSemaphore signal ]
				ifFalse: [ self error: 'Unexpected input' ] ] ].

]

{ #category : #accessing }
Spooky2SignalGenerator >> rampDownChannel: channelNumber [
	| channel |
	
	channel := channels at: channelNumber.
	channel rampDown.
	self writeCommand: (channel pWaveformCommand: 2).
	self writeCommand: channel waveformCommand.
]

{ #category : #accessing }
Spooky2SignalGenerator >> rampUpChannel: channelNumber [
	| channel |
	
	channel := channels at: channelNumber.
	channel rampUp.
	self writeCommand: (channel pWaveformCommand: 1).
	self writeCommand: channel waveformCommand.
]

{ #category : #accessing }
Spooky2SignalGenerator >> serialPort [
	^ serialPort
]

{ #category : #accessing }
Spooky2SignalGenerator >> sineWaveChannel: channelNumber [
	| channel |
	
	channel := channels at: channelNumber.
	channel sineWave.
	self writeCommand: channel waveformCommand.
]

{ #category : #accessing }
Spooky2SignalGenerator >> squareWaveChannel: channelNumber [
	| channel |
	
	channel := channels at: channelNumber.
	channel squareWave.
	self writeCommand: channel waveformCommand.
]

{ #category : #private }
Spooky2SignalGenerator >> startReadProcess [

	self
		assert: readProcess isNil
		description: 'Read process is already running'.

	readProcess := [ | buf |
		[ serialPort isNotNil ] whileTrue: [ 
			buf := serialPort readString.
			buf ifNotEmpty: [ self processReadString: buf ].
			(Delay forMilliseconds: 100) wait. ] ] forkNamed: 'Spooky2 Read Process'.

]

{ #category : #registering }
Spooky2SignalGenerator >> stopAll [

	channels do: [ :channel | self switchOffChannel: channel channel ]
]

{ #category : #accessing }
Spooky2SignalGenerator >> switchOffChannel: channelNumber [
	| channel |
	
	channel := channels at: channelNumber.
	self writeCommand: channel offCommand.
]

{ #category : #accessing }
Spooky2SignalGenerator >> switchOnChannel: channelNumber [
	| channel |
	
	channel := channels at: channelNumber.
	self writeCommand: channel onCommand.
]

{ #category : #accessing }
Spooky2SignalGenerator >> triangleWaveChannel: channelNumber [
	| channel |
	
	channel := channels at: channelNumber.
	channel triangleWave.
	self writeCommand: channel waveformCommand.
]

{ #category : #accessing }
Spooky2SignalGenerator >> writeCommand: aString [

	writeSemaphore wait.
	serialPort nextPutAll: aString, String crlf.

]
