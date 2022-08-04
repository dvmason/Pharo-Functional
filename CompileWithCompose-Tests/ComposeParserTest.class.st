Class {
	#name : #ComposeParserTest,
	#superclass : #RBParserTest,
	#category : #'CompileWithCompose-Tests'
}

{ #category : #accessing }
ComposeParserTest class >> parserClass [
	^ ComposeParser
]

{ #category : #asserting }
ComposeParserTest >> assertMessage: aRBMessageNode equals: aCollection [ 
	| node selectors |
	self assert: aRBMessageNode isMessage.
	node := aRBMessageNode.
	selectors := OrderedCollection new.
	[ node isMessage or: [node isCascade]] whileTrue: [
		node isCascade ifTrue: [
			selectors add: (node messages collect: #selector as: aCollection class)
		] ifFalse: [
			selectors add: node selector
		].
		node := node receiver.
	].
	node isSelfVariable ifTrue: [selectors add: #self].
	self assert: (aCollection class withAll: selectors) equals: aCollection.

]

{ #category : #asserting }
ComposeParserTest >> assertSourceCode: anRBNode equals: aString [ 
	self assert: anRBNode sourceCode equals: aString
]

{ #category : #tests }
ComposeParserTest >> testBlockSelector [
	self assertMessage: (self parserClass parseExpression: ' self [:x| x msg]') equals: #(yourself msg self).
	self assertMessage: (self parserClass parseExpression: ' self [:x| x msg] xxx') equals: #(yourself msg self).
	self assertMessage: (self parserClass parseExpression: ' self [:x:y| x msg: y] xxx') equals: #(yourself msg: self).

]

{ #category : #tests }
ComposeParserTest >> testCollectionLiterals [
	self assertSourceCode: (self parserClass parseExpression: ' {1. 2. 3} ') equals: '{1. 2. 3}'.
	self should: [self parserClass parseExpression: ' {:foo 1. 2. 3} ' onError: [Error signal]] raise: Error.
	self should: [self parserClass parseExpression: ' {:Set 1. 2. 3} ' onError: [Error signal]] raise: Error.
	self assertSourceCode: (self parserClass parseExpression: ' {:Array 1. 2. 3} ') equals: #(yourself msg self).
	self assertSourceCode: (self parserClass parseExpression: ' {:Dictionary #a->1. #b->2. #c->3} ') equals: #(yourself msg self).

]

{ #category : #tests }
ComposeParserTest >> testCurrySelector [
	self assertMessage: (self parserClass parseExpression: ' (+3)') equals: #(yourself msg self).
	self assertMessage: (self parserClass parseExpression: ' (3+)') equals: #(yourself msg self).
	self assertMessage: (self parserClass parseExpression: ' (+)') equals: #(yourself msg self).

]

{ #category : #tests }
ComposeParserTest >> testDesctructureCollection [
	self assertMessage: (self parserClass parseExpression: ' :| x y z | := w ') equals: #(yourself msg self).

]

{ #category : #tests }
ComposeParserTest >> testParenSelector [

	self halt.
	self
		assertMessage:
		(self parserClass parseExpression: ' self (msg yourself) xxx')
		equals: #( yourself msg self ).
	self
		assertMessage:
		(self parserClass parseExpression: ' self (arg msg:arg): xxx')
		equals: #( yourself msg: self )
]

{ #category : #tests }
ComposeParserTest >> testPipe [
	self assertMessage: (self parserClass parseExpression: ' self msg:> yourself') equals: #(yourself msg self).
	self assertMessage: (self parserClass parseExpression: ' self msg:(arg msg:arg):> yourself') equals: #(yourself msg: self).
	self assertMessage: ( self parserClass parseExpression: ' (self msg):> yourself' ) equals: #(yourself msg self).
	self assertMessage: ( self parserClass parseExpression: ' self :> yourself' ) equals: #(yourself self).
	self assertMessage: ( self parserClass parseExpression: ' (self) :> yourself' ) equals: #(yourself self).
	self assertMessage: (self parserClass parseExpression: ' self msg:(arg msg:arg); msg2: self :> yourself') equals: #(yourself (msg: msg2:) self).

]
