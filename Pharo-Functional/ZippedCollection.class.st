Class {
	#name : #ZippedCollection,
	#superclass : #SequenceableCollection,
	#instVars : [
		'first',
		'second'
	],
	#category : #'Pharo-Functional-Kernel'
}

{ #category : #adding }
ZippedCollection >> add: newObject [ 
	^ self shouldNotImplement
]

{ #category : #accessing }
ZippedCollection >> at: index [
	^ { first at: index . second at: index }
]

{ #category : #enumerating }
ZippedCollection >> collect: blockOrSymbol [
	^ blockOrSymbol argumentCount = 1 ifTrue: [
		first with: second collect: [:f :s | blockOrSymbol value: {f.s}]
	] ifFalse: [
		first with: second collect: blockOrSymbol
	]
]

{ #category : #enumerating }
ZippedCollection >> do: blockOrSymbol [
	^ blockOrSymbol argumentCount = 1 ifTrue: [
		first with: second do: [:f :s | blockOrSymbol value: {f.s}]
	] ifFalse: [
		first with: second do: blockOrSymbol
	]
]

{ #category : #accessing }
ZippedCollection >> size [
	^ first size min: second size
]

{ #category : #initialization }
ZippedCollection >> with: aCollection with: aCollection2 [ 
	first := aCollection.
	second := aCollection2.

]
