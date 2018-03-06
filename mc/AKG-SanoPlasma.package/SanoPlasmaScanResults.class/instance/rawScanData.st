accessing
rawScanData
	"Answer the raw scan data as a DataFrame"

	^DataFrame fromCSV: self fileReference header: true