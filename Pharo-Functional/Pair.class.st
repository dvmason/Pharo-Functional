"
I represent a 2 element Tuple.

I am mostly immutable, although I support replaceFrom:to:with:startingAt:
"
Class {
	#name : #Pair,
	#superclass : #Tuple,
	#instVars : [
		'other'
	],
	#category : #'Pharo-Functional-Kernel'
}

{ #category : #'instance creation' }
Pair class >> new: anInteger [
	anInteger = 2 ifFalse: [ ^ Tuple new: anInteger ].
	^ super new
]

{ #category : #accessing }
Pair >> at: index [
	index = 1 ifTrue: [ ^ value ].
	index = 2 ifTrue: [ ^ other ].
	^ self errorSubscriptBounds: index
]

{ #category : #accessing }
Pair >> first [
	^ value
]

{ #category : #initialization }
Pair >> initializeWith: anInteger with: anInteger2 [ 
	value := anInteger.
	other := anInteger2.

]

{ #category : #accessing }
Pair >> last [
	^ other
]

{ #category : #accessing }
Pair >> replaceFrom: start to: stop with: source startingAt: repStart [ 
	"This destructively replaces elements from start to stop in the receiver 
	starting at index, repStart, in the sequenceable collection, 
	source. Answer the receiver."

	start = 1 ifFalse: [ ^ self errorImproperStore ].
	stop = 2 ifFalse: [ ^ self errorImproperStore ].
	value := source at: repStart.
	other := source at: repStart+1.

]

{ #category : #accessing }
Pair >> second [
	^ other
]

{ #category : #accessing }
Pair >> size [
	^ 2
]
