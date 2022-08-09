Extension { #name : #VariableRefactoring }

{ #category : #'*Webside' }
VariableRefactoring >> asWebsideJson [
	^ super asWebsideJson
		at: 'class' put: class name;
		at: 'variable' put: variableName;
		yourself
]

{ #category : #'*Webside' }
VariableRefactoring >> fromWebsideJson: json [
	super fromWebsideJson: json.
	class := json at: 'class' ifAbsent: nil.
	class ifNotNil: [ class := self classObjectFor: class asSymbol ].
	variableName := json at: 'variable' ifAbsent: nil
]
