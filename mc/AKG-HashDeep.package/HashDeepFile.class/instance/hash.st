comparing
hash
	"Answer an integer value that is related to the identity of the receiver."

	^ fileSize hash bitXor: (hash1 hash bitXor: hash2 hash)