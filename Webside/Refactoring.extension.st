Extension { #name : #Refactoring }

{ #category : #'*Webside' }
Refactoring class >> acceptsWebsideJson: json [
	| type |
	type := json at: 'type' ifAbsent: nil.
	^ self websideType = type
]

{ #category : #'*Webside' }
Refactoring class >> classForWebsideJson: json [
	^ self allSubclasses
		detect: [ :c | c acceptsWebsideJson: json ]
		ifNone: nil
]

{ #category : #'*Webside' }
Refactoring >> fromWebsideJson: json [
]

{ #category : #'*Webside' }
Refactoring class >> fromWebsideJson: json [
	| class |
	class := self classForWebsideJson: json.
	^ class ifNotNil: [class new fromWebsideJson: json]
]

{ #category : #'*Webside' }
Refactoring class >> websideType [

	^ (self name withoutPrefix: 'RB') withoutSuffix: 'Refactoring'
]
