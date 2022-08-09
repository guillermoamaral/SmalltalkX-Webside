Extension { #name : #PullUpInstanceVariableRefactoring }

{ #category : #'*Webside' }
PullUpInstanceVariableRefactoring >> fromWebsideJson: json [
	super fromWebsideJson: json.
	class notNil
		ifTrue: [ class := class superclass ]
]

{ #category : #'*Webside' }
PullUpInstanceVariableRefactoring class >> websideType [

	^ 'MoveUpInstanceVariable'
]
