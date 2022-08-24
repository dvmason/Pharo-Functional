"
I subclass the RBParser and add syntax recognition for a compose syntax: ':>'
"
Class {
	#name : #ComposeParser,
	#superclass : #RBParser,
	#instVars : [
		'pendingBinaryOperator',
		'anonvariableNumber'
	],
	#category : #'CompileWithCompose-Kernel'
}

{ #category : #'private - parsing' }
ComposeParser >> cascadeNodeWithMessages: messages semicolons: semicolons [
	^ messages size = 1 ifTrue: [
			messages first
		] ifFalse: [
			self cascadeNodeClass messages: messages semicolons: semicolons
		]
]

{ #category : #'private - parsing' }
ComposeParser >> parseArray [

	"Although an array node represents an array, it is not an Array-like object."

	| startToken node nodeClass receiver |
	startToken := currentToken.
	self step.
	nodeClass := Array.
	(currentToken isSpecial and: [ currentToken value = $: ]) ifTrue: [ 
		self step.
		(currentToken isIdentifier and: [ 
			 Smalltalk
				 at: currentToken value asSymbol
				 ifPresent: [ :class | 
					 class isClass and: [ 
						 nodeClass := class.
						 self step.
						 true ] ]
				 ifAbsent: false ]) ifFalse: [ 
			^ self parserError: 'expected class' ] ].
	node := self arrayNodeClass new.
	node left: startToken start.
	self parseStatementList: false into: node untilAnyCloserOf: '}'.
	(currentToken isSpecial and: [ currentToken value = $} ]) ifFalse: [ 
		^ self
			  parseEnglobingError: node statements
			  with: startToken
			  errorMessage: 'expected }' ].
	node right: currentToken start.
	self step.
	nodeClass == Array ifTrue: [ ^ node ].
	receiver := (RBVariableNode named: nodeClass name) start:
		            startToken start.
	node statements size <= 6 ifTrue: [ 
		| selector |
		selector := ('' join:
			             (node statements collect: [ :ignore | 'with:' ]))
			            asSymbol.
		(nodeClass classSide canUnderstand: selector) ifTrue: [ 
			^ self messageNodeClass
				  receiver: receiver
				  selector: selector
				  arguments: node statements ] ].
	#( withAll: newFrom: ) do: [ :selector | 
		(nodeClass classSide canUnderstand: selector) ifTrue: [ 
			^ self messageNodeClass
				  receiver: receiver
				  selector: selector
				  arguments: { node } ] ].
	^ self parserError: 'Object is dupposed to understand newfrom:'
]

{ #category : #'private - parsing' }
ComposeParser >> parseAssignment [

	"Need one token lookahead to see if we have a ':='. This method could 
	make it possible to assign the literals true, false and nil."

	| node position |
	(currentToken isIdentifier and: [ self nextToken isAssignment ]) 
		ifFalse: [ currentToken isDestructure ifTrue: [^ self parseDestructure].
			^ self parsePipeOrCascadeMessage ].
	node := self parseVariableNode.
	position := currentToken start.
	self step.
	^ self assignmentNodeClass
		  variable: node
		  value: self parseAssignment
		  position: position
]

{ #category : #'private - parsing' }
ComposeParser >> parseBinaryMessage [

	| node |
	node := self parseUnaryMessage.

	[ 
	pendingBinaryOperator notNil or: [ 
		currentToken isLiteralToken ifTrue: [ self patchNegativeLiteral ].
		currentToken isBinary ] ] whileTrue: [ 
		node := self parseBinaryMessageWith: node ].
	^ node
]

{ #category : #'private - parsing' }
ComposeParser >> parseBinaryMessageCascadeWith: receiver [
	| temp |
	currentToken isLiteralToken ifTrue: [self patchNegativeLiteral].
	currentToken isBinary ifFalse: [ ^ self parserError: 'Message expected'].
	temp := self parseBinaryMessageWith: receiver.
	temp == receiver ifTrue: [ ^ self parserError: 'Message expected'].
	^ temp
]

{ #category : #'private - parsing' }
ComposeParser >> parseBinaryMessageWith: aNode [

	| binaryNode |
	pendingBinaryOperator ifNil: [ 
		binaryNode := self selectorNodeClass
			              value: currentToken value
			              keywordPositions: (Array with: currentToken start).
		self step.
		^ self messageNodeClass
			  receiver: aNode
			  selector: binaryNode
			  keywordsPositions: binaryNode keywordPositions
			  arguments: (Array with: self parseUnaryMessage) ].
	binaryNode := pendingBinaryOperator.
	pendingBinaryOperator := nil.
	^ self messageNodeClass
		  receiver: binaryNode
		  selector: #value:value:
		  keywordsPositions: #(0 0  )
		  arguments: { 
				  aNode.
				  self parseUnaryMessage }
]

{ #category : #parsing }
ComposeParser >> parseDestructure [

	| identifiers expression variable |
	self step.
	identifiers := self parseTemps.
	self step.
	self step.
	expression := self parseAssignment.
	anonvariableNumber := anonvariableNumber
		                      ifNil: [ 1 ]
		                      ifNotNil: [ anonvariableNumber + 1 ].
	variable := self variableNodeClass named:
		            #_temp_ , anonvariableNumber asString.
	^ self messageNodeClass
		  receiver: (self blockNodeClass
				   arguments: { variable }
				   body: (self sequenceNodeClass statements: (identifiers
							     with:
								     (#( firstNamed: secondNamed: thirdNamed: fourthNamed:
								         fifthNamed: sixthNamed: seventhNamed: eighthNamed:
								         ninthNamed: ) first: identifiers size)
							     collect: [ :id :sel | 
								     self assignmentNodeClass
									     variable: id
									     value: (self messageNodeClass
											      receiver: variable
											      selector: sel
											      arguments:
											      (OrderedCollection with:
												       (self literalNodeClass value: id name))) ])
						    , { variable }))
		  selector: #value:
		  arguments: (OrderedCollection with: expression)
]

{ #category : #'private - parsing' }
ComposeParser >> parsePipeMessage [
	| node |
	node := self parseCascadeMessage.
	currentToken isPipe ifFalse: [ ^ node ].
	[currentToken isPipe] whileTrue: [
		self step.
		self saveCommentsDuring:[
			node := currentToken isIdentifier 
						ifTrue: [self parseUnaryMessageWith: node]
						ifFalse: 
							[currentToken isKeyword 
								ifTrue: [self parseKeywordMessageWith: node]
								ifFalse: 
									[| temp |
									currentToken isLiteralToken ifTrue: [self patchNegativeLiteral].
									currentToken isBinary ifFalse: [ ^ self parserError: 'Message expected'].
									temp := self parseBinaryMessageWith: node.
									temp == node ifTrue: [ ^ self parserError: 'Message expected'].
									temp]]].
					
		self addCommentsTo: node].
	^ node
]

{ #category : #'private - parsing' }
ComposeParser >> parsePipeOrCascadeMessage [
	| node messages semicolons |
	node := self parseKeywordMessage.
	(currentToken isSpecial and: [ currentToken value = $; ])
		ifTrue: [ (node isVariable or: [ node hasParentheses ])
				ifTrue: [ self parserError: 'cascaded message not allowed' ] ].
	(currentToken isSpecial and: [ currentToken value = $; and: [ node isMessage ] ])
		ifFalse: [ 	currentToken isPipe ifFalse: [ ^ node ] ].
	messages := OrderedCollection with: node.
	semicolons := OrderedCollection new: 3.
	[currentToken isPipe or: [currentToken isSpecial and: [currentToken value = $;]]] whileTrue: 
			[|newMessage receiver isPipe| newMessage := nil. semicolons add: currentToken start.
				isPipe := currentToken isPipe.
				receiver := isPipe ifTrue: [
						self cascadeNodeWithMessages: messages semicolons: semicolons
					] ifFalse: [
						messages 	first receiver
					].
				self step.			self saveCommentsDuring:[
				newMessage := currentToken isIdentifier 
						ifTrue: [self parseUnaryMessageWith: receiver]
						ifFalse: 
							[currentToken isKeyword 
								ifTrue: [self parseKeywordMessageWith: receiver]
								ifFalse: [ self parseBinaryMessageCascadeWith: receiver ]]].
					
		self addCommentsTo: newMessage.
		isPipe ifTrue: [
			messages := OrderedCollection with: newMessage.
			semicolons removeAll
		] ifFalse: [
			messages add: newMessage
		].
	].
	^ self cascadeNodeWithMessages: messages semicolons: semicolons

]

{ #category : #parsing }
ComposeParser >> parseTempsWithAssignmentsInto: aSequenceNode [

	| temps identifier position |
	temps := OrderedCollection new.
	[ currentToken isIdentifier ] whileTrue: [ 
		identifier := self parsePrimitiveIdentifier.
		temps add: identifier.
		currentToken isAssignment ifTrue: [ 
			position := currentToken start.
			self step.
			aSequenceNode addNode: (self assignmentNodeClass
				variable: identifier
				value: self parseAssignment
				position: position) ].
		(currentToken isSpecial and: [ currentToken value = $. ]) ifTrue: [ 
			self step ] ].
	^ temps
]

{ #category : #'private - parsing' }
ComposeParser >> parseUnaryBlockWith: aNode [

	| block |
	^ (currentToken value = $[
		   ifTrue: [ 
			   block := self saveCommentsDuring: [ self parseBlock ].
			   block arguments size ]
		   ifFalse: [ 
			   block := self parseParenthesizedExpression.
			   currentToken value = $:
				   ifTrue: [ 
					   self step.
					   2 ]
				   ifFalse: [ 1 ] ]) = 2
		  ifTrue: [ 
			  pendingBinaryOperator := block.
			  aNode ]
		  ifFalse: [ 
			  self messageNodeClass
				  receiver: block
				  selector: #value:
				  arguments: { aNode } ]
]

{ #category : #'private - parsing' }
ComposeParser >> parseUnaryMessage [

	| node |
	node := self parsePrimitiveObject.
	self addCommentsTo: node.
	pendingBinaryOperator := nil.
	[ 
	currentToken isLiteralToken ifTrue: [ self patchLiteralMessage ].
	pendingBinaryOperator isNil and: [ 
		currentToken isIdentifier or: [ 
			'([' includes: currentToken value  ] ] ] 
		whileTrue: [ node := self parseUnaryMessageWith: node ].
	self addCommentsTo: node.
	^ node
]

{ #category : #'private - parsing' }
ComposeParser >> parseUnaryMessageWith: aNode [

	| selector block |
	currentToken isIdentifier  ifFalse: [ ^ self parseUnaryBlockWith: aNode].
			  selector := self selectorNodeClass
				              value: currentToken value
				              keywordPositions: (Array with: currentToken start).
			  self step.
	^			  self messageNodeClass
				  receiver: aNode
				  selector: selector
				  keywordsPositions: selector keywordPositions
				  arguments: #(  )
]

{ #category : #accessing }
ComposeParser >> scannerClass [
	^ ComposeScanner
]
