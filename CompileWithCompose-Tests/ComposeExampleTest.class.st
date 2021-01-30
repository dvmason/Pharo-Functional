Class {
	#name : #ComposeExampleTest,
	#superclass : #RBScannerTest,
	#traits : 'ComposeSyntax',
	#classTraits : 'ComposeSyntax classTrait',
	#category : #'CompileWithCompose-Tests'
}

{ #category : #tests }
ComposeExampleTest >> testCompose [
	self assert: (
	 17 negated
		:> min: -53
		:> abs
		:> < 100
		:> and: [ 4 > 2 ]
		:> and: [ 5 < 10 ]
		:> ifTrue: [ 42 ] ifFalse: [ 99 ]) equals: 42
]

{ #category : #tests }
ComposeExampleTest >> testMixed [
	self assert: (
	 OrderedCollection new
		:> add: -17
		; add: 25
		; collect: #abs
		:> sum) equals: 42
]

{ #category : #tests }
ComposeExampleTest >> testMixed2 [
	self assert: (
	 ComposeExample new
		 first: 99
		; second: 25
		; asOrderedCollection
		:> asArray
		:> asComposeExample
		:> first: -17
		; asOrderedCollection
		:> collect: #abs
		:> sum) equals: 42
]

{ #category : #tests }
ComposeExampleTest >> testSimple [
	self assert: (#('apple' 'peach' 'banana')
	  groupedBy: #size :>
	  select: [ :each | each size even ] :>
	  values :>
		flatCollect: #asCommaString as: String) equals: 'apple, peach'
]

{ #category : #tests }
ComposeExampleTest >> testSimple2 [
	self assert: (ComposeExample new first: 5;yourself :> + 3) equals: 8.
	self assert: (ComposeExample new first: 5; > 3).
	self assert: (ComposeExample new first: 5 :> > 3).
	self deny:   (ComposeExample new first: 5; second: 1 :> > 3).
	self assert: (ComposeExample new first: 5; second: 1; > 3).

]
