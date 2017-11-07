private
fileDictionary
	^ fileDictionary ifNil: [ fileDictionary := self constructFileDictionary ]