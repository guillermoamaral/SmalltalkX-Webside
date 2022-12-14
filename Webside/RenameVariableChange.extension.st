Extension { #name : #RenameVariableChange }

{ #category : #'*Webside' }
RenameVariableChange >> asWebsideJson [
	^super asWebsideJson
	at: 'class' put: className; at: 'variable'  put: oldName; at: 'newName'put: newName; yourself 
]

{ #category : #'*Webside' }
RenameVariableChange >> fromWebsideJson: json [
	super fromWebsideJson: json.
	className := json at: 'class' ifAbsent: nil.
	className ifNotNil: [ className := className asSymbol ].
	isMeta := className notNil and: [ className endsWith: ' class' ].
	oldName  := json at: 'variable' ifAbsent: nil.
	newName := json at: 'newName' ifAbsent: nil
]
