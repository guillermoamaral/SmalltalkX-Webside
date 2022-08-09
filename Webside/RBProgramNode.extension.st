Extension { #name : #RBProgramNode }

{ #category : #'*Webside' }
RBProgramNode >> websideType [
	^self class websideType
]

{ #category : #'*Webside' }
RBProgramNode class >> websideType [ 
	^(self name withoutPrefix: 'RB') withoutSuffix: 'Node'.
]
