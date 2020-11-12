"
I am an example class that uses the ParseWithCompose trait so that any methods will be able to use the compose operator :>

See the foo method as an example.
"
Class {
	#name : #FunctionalParseExample,
	#superclass : #Object,
	#traits : 'ParseWithCompose',
	#classTraits : 'ParseWithCompose classTrait',
	#category : #'Pharo-Functional-Tests-Examples'
}

{ #category : #accessing }
FunctionalParseExample >> foo [
	" self new foo >>> 42 "
	^ 17 negated
		:> min: -53
		:> abs
		:> < 100
		:> and: [ 4 > 2 ]
		:> and: [ 5 < 10 ]
		:> ifTrue: [ 42 ] ifFalse: [ 99 ]
]
