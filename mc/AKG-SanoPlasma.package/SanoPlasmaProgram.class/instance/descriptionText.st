printing
descriptionText
	"Answer a multi-line description of the receiver"

	^String streamContents: [ :stream |
		stream
			<< 'Name: ';
			<< name asString; cr; cr;
			<< 'Frequencies: '; cr.
		frequencies do: [ :freq |
			stream
				<< '- ';
				<< freq asString; cr ].
		stream
			<< 'Dwell: ';
			<< dwell asString; cr;
			<< 'Notes:'; cr;
			<< notes asString; cr;
			cr; cr;
			<< 'Running Time: ';
			<< runningTime asString; cr;
			<< 'Organ: ';
			<< organ asString; cr;
			<< 'Illness: ';
			<< illness asString; cr ]