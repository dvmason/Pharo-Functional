"
I represent a 2 element Tuple.

I am mostly immutable, although I support replaceFrom:to:with:startingAt:
"
Class {
	#name : #Pair,
	#superclass : #ArrayedCollection,
	#instVars : [
		'first',
		'second'
	],
	#category : #'PharoFunctional-Kernel'
}

{ #category : #'instance creation' }
Pair class >> new: anInteger [
	anInteger = 2 ifFalse: [ ^ Tuple new: anInteger ].
	^ self basicNew
]

{ #category : #'instance creation' }
Pair class >> with: first with: second [
	^ (self new: 2) initializeWith: first with: second
]

{ #category : #applying }
Pair >> apply: aBlock [
	^ aBlock argumentCount = 2 ifTrue: [
				aBlock value: first value: second
			] ifFalse: [
				aBlock cull: self
			]
]

{ #category : #accessing }
Pair >> at: index [
	index = 1 ifTrue: [ ^ first ].
	index = 2 ifTrue: [ ^ second ].
	^ self errorSubscriptBounds: index
]

{ #category : #accessing }
Pair >> at: index put: value [
	^ self errorImproperStore
]

{ #category : #accessing }
Pair >> first [
	^ first
]

{ #category : #accessing }
Pair >> firstNamed: unused [

	"Answer the first element of the receiver"

	^ first
]

{ #category : #initialization }
Pair >> initializeWith: anInteger with: anInteger2 [ 
	first := anInteger.
	second := anInteger2.

]

{ #category : #accessing }
Pair >> last [
	^ second
]

{ #category : #accessing }
Pair >> replaceFrom: start to: stop with: source startingAt: repStart [ 
	^ self errorImproperStore
]

{ #category : #accessing }
Pair >> second [
	^ second
]

{ #category : #accessing }
Pair >> secondNamed: unused [

	"Answer the second element of the receiver"

	^ second
]

{ #category : #accessing }
Pair >> size [
	^ 2
]
