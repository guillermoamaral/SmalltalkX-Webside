Class {
	#name : #WebsideAPITest,
	#superclass : #TestCase,
	#instVars : [
		'server',
		'client'
	],
	#category : #'Webside-Tests'
}

{ #category : #private }
WebsideAPITest >> post: uri [
	^ self post: uri with: ''
]

{ #category : #running }
WebsideAPITest >> tearDown [
	super tearDown.
	server stop.
]

{ #category : #'code endpoints' }
WebsideAPITest >> testAccessors [
	| accessors |
	accessors := self get: 'methods?class=Fraction&accessing=numerator'.
	self
		assert: accessors notEmpty;
		assert:
			(accessors
				allSatisfy: [ :m | m source includesSubstring: 'numerator' ]).
	accessors := self get: 'methods?class=Fraction&assigning=numerator'.
	self
		assert: accessors notEmpty;
		assert:
			(accessors
				allSatisfy: [ :m | m source includesSubstring: 'numerator :=' ])
]

{ #category : #'code endpoints' }
WebsideAPITest >> testAst [
	| method ast traverse return x |
	method := self get: 'classes/Point/methods/x?ast=true'.
	ast := method ast.
	self assert: ast notNil.
	traverse := [ :node :block | 
	block value: node.
	(node includesKey: 'children')
		ifTrue: [ (node at: 'children')
				do: [ :child | traverse value: child value: block ] ] ].
	traverse
		value: ast
		value: [ :n | 
			(n at: 'type') = 'Return'
				ifTrue: [ return := n ] ].
	self assert: return notNil.
	traverse
		value: return
		value: [ :n | 
			((n at: 'type') = 'Identifier' and: [ (n at: 'value') = 'x' ])
				ifTrue: [ x := n ] ].
	self assert: x notNil
]

{ #category : #'code endpoints' }
WebsideAPITest >> testCategories [
	| categories |
	categories := self get: 'classes/Point/categories'.
	self
		assert: categories notEmpty;
		assert: (categories allSatisfy: #isString);
		assert: (categories includes: 'arithmetic')
		
  
]

{ #category : #'code endpoints' }
WebsideAPITest >> testClassDefinition [
	| definition |
	definition := self get: 'classes/Point'.
	self
		assert: definition name equals: 'Point';
		assert: (definition definition includesSubstring: 'x');
		assert: (definition definition includesSubstring: 'y')
]

{ #category : #'code endpoints' }
WebsideAPITest >> testClassVariables [
	| variables |
	variables := self get: 'classes/Float/class-variables'.
	self assert: (variables anySatisfy: [ :v | (v at: 'name') = 'Infinity' and: [(v at: 'type') = 'class']])
]

{ #category : #'code endpoints' }
WebsideAPITest >> testClasses [
	| classes names tree root integer |
	classes := self get: 'classes?root=Magnitude'.
	self
		assert: (classes anySatisfy: [ :c | c name = 'Date' ]);
		assert:
			(classes
				anySatisfy: [ :c | 
					c name = 'Fraction'
						and: [ c definition includesSubstring: 'denominator' ] ]).
	names := self get: 'classes?root=Magnitude&names=true'.
	self
		assert: names notEmpty;
		assert: (names allSatisfy: #isString).
	tree := self get: 'classes?root=Number&tree=true'.
	self
		assert: tree isCollection;
		assert: tree size equals: 1.
	root := tree first.
	self
		assert: root name = 'Number';
		assert: (root subclasses anySatisfy: [ :c | c name = 'Integer' ]).
	integer := root subclasses detect: [ :c | c name = 'Integer' ].
	self
		assert: (integer subclasses anySatisfy: [ :c | c name = 'SmallInteger' ])
]

{ #category : #'code endpoints' }
WebsideAPITest >> testDialect [
	| dialect |
	dialect := self get: 'dialect'.
	self assert: dialect equals: 'Pharo'
]

{ #category : #'code endpoints' }
WebsideAPITest >> testImplementors [
	| implementors local |
	implementors := self get: 'methods?selector=reciprocal'.
	self
		assert: implementors notEmpty;
		assert: (implementors allSatisfy: [ :m | m selector = 'reciprocal' ]);
		assert: (implementors anySatisfy: [ :m | (m at: 'class') = 'Fraction' ]).
	local := self get: 'methods?selector=reciprocal&class=Fraction'.
	self
		assert: local notEmpty;
		assert: (local allSatisfy: [ :m | m selector = 'reciprocal' ]);
		assert: (local allSatisfy: [ :m | (m at: 'class') = 'Fraction' ])
]

{ #category : #'code endpoints' }
WebsideAPITest >> testInstanceVariables [
	| variables |
	variables := self get: 'classes/Fraction/instance-variables'.
	self
		assert: (variables anySatisfy: [ :v | v name = 'numerator' ]);
		assert: (variables anySatisfy: [ :v | v name = 'denominator' ])
]

{ #category : #'code endpoints' }
WebsideAPITest >> testMatchingSelectors [
	| matching |
	matching := self get: 'methods?selectorMatching=testMa*'.
	self
		assert: matching notEmpty;
		assert: (matching
			anySatisfy: [:m | (m at: 'selector') = 'testMatchingSelectors'])
]

{ #category : #'code endpoints' }
WebsideAPITest >> testMethod [
	| method |
	method := self get: 'classes/Point/methods/x'.
	self
		assert: method selector equals: 'x';
		assert:
			((method source includesSubstring: '^x')
				or: [ method source includesSubstring: '^ x' ])
]

{ #category : #'code endpoints' }
WebsideAPITest >> testMethods [
	| methods |
	methods := self get: 'classes/Point/methods'.
	self
		assert: methods notEmpty;
		assert: (methods allSatisfy: [ :m | (m at: 'class') = 'Point' ])
]

{ #category : #'code endpoints' }
WebsideAPITest >> testPackage [
	| package |
	package := self get: 'packages/Webside'.
	self
		assert: package notNil;
		assert: (package at: 'classes') notEmpty;
		assert: (package at: 'methods') notEmpty
]

{ #category : #'code endpoints' }
WebsideAPITest >> testPackageClasses [
	| classes |
	classes := self get: 'packages/Webside/classes'.
	self
		assert: (classes anySatisfy: [ :c | (c at: 'name') = 'WebsideAPI' ]);
		deny: (classes anySatisfy: [ :c | (c at: 'name') = 'Object' ]).
	classes := self get: 'packages/Webside/classes?extended=true'.
	self
		assert: (classes anySatisfy: [ :c | (c at: 'name') = 'Object' ])
]

{ #category : #'code endpoints' }
WebsideAPITest >> testPackageMethods [
	| methods |
	methods := self get: 'packages/Webside/methods'.
	self
		assert: methods notEmpty;
		assert: (methods anySatisfy: [ :m | (m at: 'class') = 'Object' and: [ (m at: 'selector') = 'asWebsideJson' ]]) 
]

{ #category : #'code endpoints' }
WebsideAPITest >> testPackages [
	| packages package |
	packages := self get: 'packages'.
	package := packages
		detect: [ :p | p name = 'Webside' ]
		ifNone: [ self assert: false ].
	self assert: ((package at: 'classes') includes: 'WebsideAPI'); assert: ((package at: 'methods') includesKey: 'Object'); assert: (((package at: 'methods') at: 'Object') includes: 'asWebsideJson')
]

{ #category : #'code endpoints' }
WebsideAPITest >> testReferencesToClass [
	| references |
	references := self get: 'methods?referencingClass=Fraction'.
	self
		assert: references notEmpty;
		assert:
			(references
				allSatisfy: [ :m | m source includesSubstring: 'Fraction' ])
]

{ #category : #'code endpoints' }
WebsideAPITest >> testReferencesToString [
	| references |
	references := self get: 'methods?referencingString=referencingString'.
	self
		assert: references notEmpty;
		assert:
			(references
				allSatisfy: [ :m | m source includesSubstring: 'referencingString' ])
]

{ #category : #'code endpoints' }
WebsideAPITest >> testScope [
	| methods hierarchy retrieved |
	methods := self get: 'methods?scope=Collection&sending=notEmpty'.
	self assert: methods notEmpty.
	hierarchy := Collection withAllSuperAndSubclasses collect: [ :c | c name ].
	retrieved := (methods collect: [ :m | m at: 'class' ]) asSet.
	self assert: retrieved size > 1; assert: (retrieved allSatisfy: [:n |  hierarchy includes: n]) 
]

{ #category : #'code endpoints' }
WebsideAPITest >> testSenders [
	| senders local |
	senders := self get: 'methods?sending=reciprocal'.
	self
		assert: senders notEmpty;
		assert: (senders allSatisfy: [ :m | m source includesSubstring: 'reciprocal' ]);
		assert: (senders anySatisfy: [ :m | (m at: 'class') = 'Fraction' ]).
	local := self get: 'methods?sending=reciprocal&class=Fraction'.
	self
		assert: local notEmpty;
		assert: (local allSatisfy: [ :m | m source includesSubstring: ' reciprocal' ]);
		assert: (local allSatisfy: [ :m | (m at: 'class') = 'Fraction' ])
]

{ #category : #'code endpoints' }
WebsideAPITest >> testSubclasses [
	| subclasses |
	subclasses := self get: 'classes/Magnitude/subclasses'.
	self
		assert: (subclasses anySatisfy: [ :c | c name = 'Time' ]);
		assert: (subclasses anySatisfy: [ :c | c name = 'Number' ])
]

{ #category : #'code endpoints' }
WebsideAPITest >> testVariables [
	| variables |
	variables := self get: 'classes/Float/variables'.
	self assert: (variables anySatisfy: [ :v | (v at: 'name') = 'Infinity' and: [(v at: 'type') = 'class']]).
	variables := self get: 'classes/Fraction/variables'.
	self
		assert: (variables anySatisfy: [ :v | (v at:'name') = 'numerator' and: [(v at: 'type') = 'instance']]);
		assert: (variables anySatisfy: [ :v | (v at:'name') = 'denominator' and: [(v at: 'type') = 'instance']])
]

{ #category : #'workspaces endpoints' }
WebsideAPITest >> testWorkspaces [
	| id result |
	id := self post: '/workspaces'.
	[result := self get: '/workspaces'.
	self
		assert: (result anySatisfy: [:w | (w at: 'id') = id])]
		ensure: [ self delete: '/workspaces/' , id ]
]
