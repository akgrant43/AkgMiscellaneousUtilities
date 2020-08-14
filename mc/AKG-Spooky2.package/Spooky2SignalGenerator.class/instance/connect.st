actions
connect
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