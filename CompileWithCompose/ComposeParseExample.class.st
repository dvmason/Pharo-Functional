"
I am an example class that uses the ComposeSyntax trait so that any methods will be able to use the compose operator :>

See the foo method as an example.
"
Class {
	#name : #ComposeParseExample,
	#superclass : #Object,
	#traits : 'ComposeSyntax',
	#classTraits : 'ComposeSyntax classTrait',
	#category : #'CompileWithCompose-Example'
}

{ #category : #accessing }
ComposeParseExample >> foo [
	" self new foo >>> 42 "
	^ 17 negated
		:> min: -53
		:> abs
		:> < 100
		:> and: [ 4 > 2 ]
		:> and: [ 5 < 10 ]
		:> ifTrue: [ 42 ] ifFalse: [ 99 ]
]
