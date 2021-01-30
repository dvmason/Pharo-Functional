"
I subclass the RBParser and add syntax recognition for a compose syntax: ':>'
"
Class {
	#name : #ComposeParser,
	#superclass : #RBParser,
	#category : #'CompileWithCompose-Kernel'
}

{ #category : #'as yet unclassified' }
ComposeParser >> cascadeNodeWithMessages: messages semicolons: semicolons [
	^ messages size = 1 ifTrue: [
			messages first
		] ifFalse: [
			self cascadeNodeClass messages: messages semicolons: semicolons
		]
]

{ #category : #'private-parsing' }
ComposeParser >> parseAssignment [
	"Need one token lookahead to see if we have a ':='. This method could 
	make it possible to assign the literals true, false and nil."

	| node position |
	(currentToken isIdentifier and: [self nextToken isAssignment]) 
		ifFalse: [^self parsePipeOrCascadeMessage].
	node := self parseVariableNode.
	position := currentToken start.
	self step.
	^self assignmentNodeClass 
		variable: node
		value: self parseAssignment
		position: position
]

{ #category : #parsing }
ComposeParser >> parseBinaryMessageCascadeWith: receiver [
	| temp |
	currentToken isLiteralToken ifTrue: [self patchNegativeLiteral].
	currentToken isBinary ifFalse: [ ^ self parserError: 'Message expected'].
	temp := self parseBinaryMessageWith: receiver.
	temp == receiver ifTrue: [ ^ self parserError: 'Message expected'].
	^ temp
]

{ #category : #'private-parsing' }
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

{ #category : #'private-parsing' }
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

{ #category : #accessing }
ComposeParser >> scannerClass [
	^ ComposeScanner
]
