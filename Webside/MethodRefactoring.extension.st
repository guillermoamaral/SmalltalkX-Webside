Extension { #name : #MethodRefactoring }

{ #category : #'*Webside' }
MethodRefactoring >> asWebsideJson [
	^ super asWebsideJson
		at: 'class' put: class name;
		yourself
]

{ #category : #'*Webside' }
MethodRefactoring >> fromWebsideJson: json [
	super fromWebsideJson: json.
	class := json at: 'class' ifAbsent: nil.
	class ifNotNil: [class := self classObjectFor: class asSymbol].
]
