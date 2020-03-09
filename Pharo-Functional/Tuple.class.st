"
I represent an n element Tuple.

I am mostly immutable, although I support replaceFrom:to:with:startingAt:
"
Class {
	#name : #Tuple,
	#superclass : #SequenceableCollection,
	#instVars : [
		'value'
	],
	#category : #'Pharo-Functional-Kernel'
}

{ #category : #'instance creation' }
Tuple class >> with: first [
	^ self new initializeWith: {first}
]

{ #category : #'instance creation' }
Tuple class >> with: first with: second [
	^ (Pair new: 2) initializeWith: first with: second
]

{ #category : #'instance creation' }
Tuple class >> with: first with: second with: third [
	^ self new initializeWith: {first. second. third}
]

{ #category : #adding }
Tuple >> add: newObject [
	self shouldNotImplement
]

{ #category : #accessing }
Tuple >> at: index [
	^ value at: index
]

{ #category : #accessing }
Tuple >> at: index put: unused [
	^ self errorImproperStore
]

{ #category : #initialization }
Tuple >> initializeWith: aCollection [
	value := aCollection.

]

{ #category : #accessing }
Tuple >> size [
	^ value size
]
