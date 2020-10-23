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
Tuple class >> new: size [
	size = 2 ifTrue: [ ^ Pair new: 2 ].
	^ self new initializeWith: (Array new: size)
]

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

{ #category : #'instance creation' }
Tuple class >> withAll: aCollection [
	^ self new initializeWith: (aCollection collect: #yourself into: (Array new: aCollection size))
]

{ #category : #adding }
Tuple >> add: newObject [
	self shouldNotImplement
]

{ #category : #adding }
Tuple >> addFirst: newObject [
	self shouldNotImplement
]

{ #category : #adding }
Tuple >> addLast: newObject [
	self shouldNotImplement
]

{ #category : #applying }
Tuple >> apply: aBlock [
	^ aBlock argumentCount = value size ifTrue: [
				aBlock valueWithArguments: value
			] ifFalse: [
				aBlock cull: self
			]

]

{ #category : #applying }
Tuple >> applyTest: aBlock [
	^ self apply: aBlock
]

{ #category : #accessing }
Tuple >> at: index [
	^ value at: index
]

{ #category : #accessing }
Tuple >> at: index put: unused [
	^ self errorImproperStore
]

{ #category : #private }
Tuple >> initializeWith: aCollection [
	" this should only be used if we know the value is unreferenced anywhere "
	value := aCollection.

]

{ #category : #accessing }
Tuple >> replaceFrom: start to: stop with: source startingAt: repStart [
	"This destructively replaces elements from start to stop in the receiver 
	starting at index, repStart, in the sequenceable collection, 
	source. Answer the receiver."

	value replaceFrom: start to: stop with: source startingAt: repStart.

]

{ #category : #accessing }
Tuple >> size [
	^ value size
]
