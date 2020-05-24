initialization
initializeWidgets 

	name := self newTextInput.
	nameLabel := self newLabel label: 'Name:'.
	description := self newText.
	descriptionLabel := self newLabel label: 'Description:'.

	saveButton := self newButton label: 'Save'.
	loadButton := self newButton label: 'Load'.

	self focusOrder 
		add: name;
		add: description.