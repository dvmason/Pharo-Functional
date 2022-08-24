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

	collection := aCollection.
	anInteger < anInteger3
		ifTrue: [ 
			offset := anInteger - 1.
			size := anInteger3 - anInteger + 1.
			direction := 1 ]
		ifFalse: [ 
			offset := anInteger + 1.
			size := anInteger - anInteger3 + 1.
			direction := -1 ].
	mutable := false
]

{ #category : #initialization }
Slice >> mutable [
	mutable := true
]

{ #category : #converting }
Slice >> reversed [

	| rev |
	rev := self class new collection: collection from: size*direction+offset to: offset+1.
	mutable ifTrue: [ rev mutable ].
	^ rev
]

{ #category : #accessing }
Slice >> size [

	^ size
]

{ #category : #private }
Slice >> species [
	^ Array
]
