"
I capture a slice from a SequenceableCollection and allow it to be treated as a collection in its own right.

The resulting collection will be immutable unless the mutable messagee is sent.
"
Class {
	#name : #Slice,
	#superclass : #SequenceableCollection,
	#instVars : [
		'collection',
		'size',
		'offset',
		'mutable',
		'direction'
	],
	#category : #'PharoFunctional-Kernel'
}

{ #category : #adding }
Slice >> add: newObject [

	^ self errorImproperStore
]

{ #category : #initialization }
Slice >> allButFirst: n [

	^ self class new
		  collection: collection
		  offset: offset + direction
		  size: size - 1
		  direction: direction
		  mutable: mutable
]

{ #category : #initialization }
Slice >> allButLast: n [

	^ self class new
		  collection: collection
		  offset: offset
		  size: size - 1
		  direction: direction
		  mutable: mutable
]

{ #category : #converting }
Slice >> asString [

	self species == ByteString ifFalse: [ ^ super asString ].
	^ self collect: [ :x | x ]
]

{ #category : #accessing }
Slice >> at: index [

	(index < 1 or: [ index > size ]) ifTrue: [ 
		^ self errorSubscriptBounds: index ].
	^ collection at: index* direction +offset
]

{ #category : #accessing }
Slice >> at: index put: data [

	mutable ifFalse: [ ^ self errorImproperStore ].
	(index < 1 or: [ index > size ]) ifTrue: [ 
		^ self errorSubscriptBounds: index ].
	^ collection at: index*direction+offset put: data
]

{ #category : #initialization }
Slice >> collection: aCollection from: anInteger to: anInteger3 [

	^ self
		  collection: aCollection
		  offset: anInteger - 1
		  size: anInteger3 - anInteger + 1
		  direction: 1
		  mutable: false
]

{ #category : #private }
Slice >> collection: aCollection offset: theOffset size: theSize direction: theDirection mutable: mutability [
	collection := aCollection.
	offset := theOffset.
	size := theSize.
	direction := theDirection.
	mutable := mutability
]

{ #category : #initialization }
Slice >> mutable [
	mutable := true
]

{ #category : #converting }
Slice >> reversed [

	^ self class new
		  collection: collection
		  offset: (size + 1) * direction + offset
		  size: size
		  direction: direction negated
		  mutable: mutable
]

{ #category : #accessing }
Slice >> size [

	^ size
]

{ #category : #private }
Slice >> species [

	^ collection species
]
