private
recentVMsFromNode: aChromeNode
	"Answer a list of recent VMs listed on the supplied page (ChromeNode)"

	| tables table rows columnIndex dateIndex sizeIndex nameHeading dateHeading sizeHeading latest sixMonths today |

	tables := aChromeNode extractTables.
	nameHeading := 'Name'.
	dateHeading := 'Last modified'.
	sizeHeading := 'Size'.
	table := tables detect: [ :tableData | tableData first includes: nameHeading ].
	columnIndex := table first indexOf: nameHeading.
	dateIndex := table first indexOf: dateHeading.
	sizeIndex := table first indexOf: sizeHeading.
	rows := table collect: [ :each | | entry |
		entry := each at: columnIndex.
		{ entry. (self dateFromName: entry). (each at: sizeIndex). } ].
	rows := rows select: [ :each | each second isNotNil ].
	today := Date today.
	sixMonths := Duration weeks: 26.
	rows := rows select: [ :each | 
		each second isNotNil and: [ (today - each second) < sixMonths ] ].
	latest := table select: [ :each | (each at: columnIndex) includesSubstring: 'latest' ].
	latest := latest collect: [ :each | 
		{ (each at: columnIndex). (Date fromString: (each at: dateIndex)). (each at: sizeIndex). } ].
	rows := rows, latest.
	rows := rows sorted: [ :a :b | a second > b second ].
	^rows