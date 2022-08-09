Extension { #name : #AddClassChange }

{ #category : #'*Webside' }
AddClassChange >> fromWebsideJson: json [
	
	super fromWebsideJson: json.
	definition := json at: 'definition' ifAbsent: ''.
	(definition includesSubstring: 'category:')
		ifFalse: [ definition := definition , ' category: #Undefined' ]
]
