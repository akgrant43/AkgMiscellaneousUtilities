CliScript to convert filenames containing non-ascii characters to a purely ascii representation, and optionally avoid characters that Windows doesn't support.

Format:

	AsciiFilename [FILENAME...]
	
options:

	-n - Dry-run, only print the names
	-r - Recurse in to subdirectories (not yet implemented)
	--replace=<replacement string> Replace illegal characters with the supplied string.
	--windows - Remove / replace characters not allowed on Windows
	