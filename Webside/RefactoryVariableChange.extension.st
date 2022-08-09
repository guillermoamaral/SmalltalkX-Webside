Extension { #name : #RefactoryVariableChange }

{ #category : #'*Webside' }
RefactoryVariableChange >> asWebsideJson [
	^ super asWebsideJson
		at: 'variable' put:  variable;
		yourself
]

{ #category : #'*Webside' }
RefactoryVariableChange >> fromWebsideJson: json [
	super fromWebsideJson: json.
	variable := json at: 'variable' ifAbsent: nil
]
