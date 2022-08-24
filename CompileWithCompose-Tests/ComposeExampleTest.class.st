Class {
	#name : #ComposeExampleTest,
	#superclass : #RBScannerTest,
	#traits : 'ComposeSyntax',
	#classTraits : 'ComposeSyntax classTrait',
	#category : #'CompileWithCompose-Tests'
}

{ #category : #tests }
ComposeExampleTest >> testArrayLiterals [
	self assert: {:Dictionary #a->1. #b->2. #c->3} equals: {#a->1. #b->2. #c->3} asDictionary.
	self assert: {:Set 1. 2. 3} equals: #(1 2 3) asSet.
	self assert: {:Tuple 1. 2. 3. 4} equals: (Tuple withAll: {1. 2. 3. 4}).
	self assert: {:Pair 1. 2} equals: (Pair with: 1 with: 2)
	
]

{ #category : #tests }
ComposeExampleTest >> testAssignDeclarations [
	| a b := 40|2. c|
	self assert: a isNil.
	self assert: b equals: 42.
	self assert: c isNil.

]

{ #category : #tests }
ComposeExampleTest >> testBlockOperators [
	self assert: 3 [ :x | x*14 ] equals: 42.
	self assert: 3 [ :x :y | x*y*2 ] 7 equals: 42.
	self assert: 3 [ :x | x [:y| y*2] ] [ :x :y | x [:z| z+1] [:z :w| z@w] y ] 4 [:x| x+3] equals: 7@7.

]

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
ComposeExampleTest >> testDestructure [
	| x y z w |
	w := :| x y z | := #(99 42 17).
	self assert: x equals: 99.
	self assert: y equals: 42.
	self assert: z equals: 17.
	self assert: w equals: #(99 42 17).
	:| x y z | := {:Dictionary #a -> 12. #x -> 42. #y -> 17. #z -> 99}.
	self assert: x equals: 42.
	self assert: y equals: 17.
	self assert: z equals: 99.
	:| x y | := { :Bag #x. #y. #x. #x. #y }.
	self assert: x equals: 3.
	self assert: y equals: 2.
	:| x y z | := { :Set #x. #x. #z }.
	self assert: x.
	self deny: y.
	self assert: z.

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
ComposeExampleTest >> testParenOperators [
	| flag |
	flag := true.
	self assert: 3 ( flag ifTrue: [#negated] ifFalse: [#abs] ) equals: -3.
	self assert: 6 ( #* ): 7 equals: 42.
	self assert: 3 ( #raised [ :x :y | (x (#,): y ,':') asSymbol ] #To ): 4 equals: 81.

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
	self assert: (ComposeExample new first: 5; second: 1; yourself :> > 3).
	self assert: (ComposeExample new first: 5; second: 1; > 3).

]
