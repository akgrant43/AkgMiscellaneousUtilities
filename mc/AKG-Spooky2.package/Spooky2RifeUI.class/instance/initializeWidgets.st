initialization
initializeWidgets

	tabmgr := self newTabManager.

	loadTab := self newTab.
	loadTab presenter: Spooky2RifeSaveUI new.
	loadTab
		label: 'Save/Load';
		closeable: false.
	tabmgr addTab: loadTab.

	runTab := self newTab.
	runTab presenter: Spooky2RifeRunUI new.
	runTab 
		label: 'Run';
		closeable: false.
	tabmgr addTab: runTab.