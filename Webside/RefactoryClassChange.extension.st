Extension { #name : #RefactoryClassChange }

{ #category : #'*Webside' }
RefactoryClassChange >> asWebsideJson [

	| moniker |
	moniker := className ifNotNil: [ 
				isMeta
					ifTrue: [ className , ' class' ]
					ifFalse: [ className ] ].
	^ super asWebsideJson
		  at: 'class' put: moniker asString;
		  yourself
]

{ #category : #'*Webside' }
RefactoryClassChange >> fromWebsideJson: json [

	super fromWebsideJson: json.
	className := json at: 'class' ifAbsent: nil.
	isMeta := className notNil and: [ className endsWith: ' class' ].
	className ifNotNil: [ 
		className := (className withoutSuffix: ' class') asSymbol ].
]
