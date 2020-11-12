Class {
	#name : #ComposeParserTest,
	#superclass : #RBParserTest,
	#category : #'Pharo-Functional-Tests-Tests'
}

{ #category : #accessing }
ComposeParserTest class >> parserClass [
	^ ComposeParser
]

{ #category : #tests }
ComposeParserTest >> testPipe [
	self assert: (self parserClass parseExpression: ' self msg:> yourself') isPipe.
	self assert: (self parserClass parseExpression: ' self msg:(arg msg:arg):> yourself') isPipe.
	self assert: [ self parserClass parseExpression: ' (self msg):> yourself' ] isPipe.
	self assert: [ self parserClass parseExpression: ' self :> yourself' ] isPipe.
	self assert: [ self parserClass parseExpression: ' (self) :> yourself' ] isPipe.
	self assert: (self parserClass parseExpression: ' self msg:(arg msg:arg); msg: self :> yourself') isPipe.

]
