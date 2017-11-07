accessing
fileDictionary
	^ fileDictionary ifNil: [ fileDictionary := self constructFileDictionary ]