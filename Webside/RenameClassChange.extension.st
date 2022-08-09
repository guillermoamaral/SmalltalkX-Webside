Extension { #name : #RenameClassChange }

{ #category : #'*Webside' }
RenameClassChange >> fromWebsideJson: json [
	super fromWebsideJson: json.
	oldName := json at: 'class' ifAbsent: nil.
	newName := json at: 'newName' ifAbsent: nil.
]
