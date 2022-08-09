Extension { #name : #RemoveMethodChange }

{ #category : #'*Webside' }
RemoveMethodChange >> asWebsideJson [
	^super asWebsideJson at: 'selector' put: selector; yourself
]

{ #category : #'*Webside' }
RemoveMethodChange >> fromWebsideJson: json [
	super fromWebsideJson: json.
	selector := json at: 'selector' ifAbsent: nil.
	selector ifNotNil: [selector := selector asSymbol]
]
