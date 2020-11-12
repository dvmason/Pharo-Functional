Class {
	#name : #ComposeParserTest,
	#superclass : #RBParserTest,
	#category : #'Pharo-Functional-Tests-Tests'
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
	node isSelf ifTrue: [selectors add: #self].
	self assert: (aCollection class withAll: selectors) equals: aCollection.

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
