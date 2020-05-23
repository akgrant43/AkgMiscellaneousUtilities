accessing
writeCommand: aString

	writeSemaphore wait.
	serialPort nextPutAll: aString, String crlf.
