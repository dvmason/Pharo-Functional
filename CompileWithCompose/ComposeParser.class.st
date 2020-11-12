"
I subclass the RBParser and add syntax recognition for a compose syntax: ':>'
"
Class {
	#name : #ComposeParser,
	#superclass : #RBParser,
	#category : #'CompileWithCompose-Kernel'
}

{ #category : #'private-parsing' }
ComposeParser >> parseAssignment [
	"Need one token lookahead to see if we have a ':='. This method could 
	make it possible to assign the literals true, false and nil."

	| node position |
	(currentToken isIdentifier and: [self nextToken isAssignment]) 
		ifFalse: [^self parsePipeMessage].
	node := self parseVariableNode.
	position := currentToken start.
	self step.
	^self assignmentNodeClass 
		variable: node
		value: self parseAssignment
		position: position
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

{ #category : #accessing }
ComposeParser >> scannerClass [
	^ ComposeScanner
]
