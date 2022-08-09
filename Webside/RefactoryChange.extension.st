Extension { #name : #RefactoryChange }

{ #category : #'*Webside' }
RefactoryChange class >> acceptsWebsideJson: json [
	| type |
	type := json at: 'type' ifAbsent: nil.
	^ self websideType = type
]

{ #category : #'*Webside' }
RefactoryChange class >> classForWebsideJson: json [
	^ self allSubclasses
		detect: [ :c | c acceptsWebsideJson: json ]
		ifNone: nil
]

{ #category : #'*Webside' }
RefactoryChange >> fromWebsideJson: json [
]

{ #category : #'*Webside' }
RefactoryChange class >> fromWebsideJson: json [
	| class |
	class := self classForWebsideJson: json.
	^ class ifNotNil: [ class new fromWebsideJson: json ] 
]

{ #category : #'*Webside' }
RefactoryChange class >> websideType [

	^ (self name withoutPrefix: 'RB') withoutSuffix: 'Change' 
]
