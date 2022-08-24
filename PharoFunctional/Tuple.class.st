"
I represent an n element Tuple.

I am mostly immutable, although I support replaceFrom:to:with:startingAt:
"
Class {
	#name : #Tuple,
	#superclass : #Array,
	#type : #variable,
	#category : #'PharoFunctional-Kernel'
}

{ #category : #'instance creation' }
Tuple class >> new: size [
	size = 2 ifTrue: [ ^ Pair new: 2 ].
	^ super new: size
]

{ #category : #'instance creation' }
Tuple class >> with: first [
	^ (self new: 1) initializeWith: {first}
]

{ #category : #'instance creation' }
Tuple class >> with: first with: second [
	^ (Pair new: 2) initializeWith: first with: second
]

{ #category : #'instance creation' }
Tuple class >> with: first with: second with: third [
	^ (self new: 3) initializeWith: {first. second. third}
]

{ #category : #'instance creation' }
Tuple class >> with: first with: second with: third with: fourth [

	^ (self new: 4) initializeWith: { 
			  first.
			  second.
			  third. fourth }
]

{ #category : #'instance creation' }
Tuple class >> with: first with: second with: third with: fourth with: fifth [

	^ (self new: 5) initializeWith: { 
			  first.
			  second.
			  third.
			  fourth. fifth }
]

{ #category : #'instance creation' }
Tuple class >> with: first with: second with: third with: fourth with: fifth withh: sixth [

	^ (self new: 5) initializeWith: { 
			  first.
			  second.
			  third.
			  fourth.
			  fifth. sixth }
]

{ #category : #'instance creation' }
Tuple class >> withAll: aCollection [

	^ (self new: aCollection size) initializeWith: aCollection
]

{ #category : #adding }
Tuple >> add: newObject [
	self shouldNotImplement
]

{ #category : #accessing }
Tuple >> at: index put: unused [
	^ self errorImproperStore
]

{ #category : #private }
Tuple >> initializeWith: aCollection [
	" this should only be used if we know the value is unreferenced anywhere "
	aCollection withIndexDo: [: value : idx | super at: idx put: value].

]

{ #category : #accessing }
Tuple >> replaceFrom: start to: stop with: source startingAt: repStart [
	^ self errorImproperStore
]
