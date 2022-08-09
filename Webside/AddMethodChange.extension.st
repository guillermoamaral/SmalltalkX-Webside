Extension { #name : #AddMethodChange }

{ #category : #'*Webside' }
AddMethodChange >> asWebsideJson [
	| json |
	json := super asWebsideJson.
	self source ifNotNil: [ :s | json at: 'sourceCode' put: s ].
	^ json
		at: 'selector' put: self selector;
		at: 'category' put: self protocol;
		yourself
]
