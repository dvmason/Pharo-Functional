Class {
	#name : #FunctionalTest,
	#superclass : #TestCase,
	#category : #'PharoFunctional-Tests-Tests'
}

{ #category : #tests }
FunctionalTest >> testAdjacentFind [
	self assert: (#(1 2 3 3 1 1 4) adjacentFind: #=) first equals: 3.
	self assert: ((#(1 2 3) adjacentFind: #=) nilOr: #first) equals: nil.

]

{ #category : #tests }
FunctionalTest >> testAsPairWith [
	self assert: (#a asPairWith: #b) equals: (Pair with: #a	 with: #b ).
	self assert: (0 asPairWith: 1) equals: (Pair with: 0	 with: 1 ). 
]

{ #category : #tests }
FunctionalTest >> testCombinations [
	self assert: (3 iota combinationsOf: 2) asSet equals: #((1 2) (1 3) (2 3)) asSet.
	self assert: (3 iota combinationsOf: 2 select: [: each | each sum = 4]) equals: #((1 3)).
	self assert: (3 iota combinationsOf: 2 select: [: each | each sum = 4] collect: [: each | each first]) equals: #(1).
	self assert: (3 iota combinationsOf: 2 collect: [: each | each sum]) asSet equals: #(3 4 5) asSet.

]

{ #category : #tests }
FunctionalTest >> testCompose [ 
	|inc|
	inc:=[ :x | x+1].
	
	self assert: ( inc <+ inc <+ 1 ) equals: 3.
	self assert: ( inc <+ inc <+ [1+5] )  equals: 8.
]

{ #category : #tests }
FunctionalTest >> testCurry [
	self assert: (5 @@ #- value: 4) equals: 1.
	self assert: (#- @@ 4 value: 9) equals: 5.
	self assert: ((5 curry: #-) value: 4) equals: 1.
	self assert: ((#- curry: 4) value: 9) equals: 5.
	self assert: ((5 curry: [:l :r | l-r]) value: 4) equals: 1.
	self assert: (([:l :r | l-r] curry: 4) value: 9) equals: 5.

]

{ #category : #tests }
FunctionalTest >> testCycle [
   self assert: (#(1 2 3 4) cycle: 2)  equals: #(1 2).
   self assert: (#(1 2 3 4) cycle: 3)  equals: #(1 2 3).
   self assert: (#(1 2 3 4) cycle: 6)  equals: #(1 2 3 4 1 2).
   self assert: (#(1 2 3 4) cycle: 10) equals: #(1 2 3 4 1 2 3 4 1 2)
]

{ #category : #tests }
FunctionalTest >> testPipeTo [
	|inc|.
	inc:=[ :x | x+1].
	self assert: (1 +> inc  ) equals: 2.
	self assert: ([1] +> inc +> inc ) equals: 3.
	self assert: ([2*2-2] +> inc +> inc ) equals: 4.
	self assert: ({3. 2.} +> [ :a| a sum ] )  equals: 5.
]

{ #category : #tests }
FunctionalTest >> testProduct [
   self assert: (#()        product) equals: 1.
   self assert: (#(1)       product) equals: 1.
   self assert: (#(1 2)     product) equals: 2.
   self assert: (#(1 2 3)   product) equals: 6.
   self assert: (#(1 2 3 4) product) equals: 24.

]

{ #category : #tests }
FunctionalTest >> testReplace [
	| x dict |
	x := 'abc','defd'.
	dict := {$a->$z . $d->$w} asDictionary.
	self assert: (x copyReplace: dict) equals: 'zbcwefw'.
	self assert: x equals: 'abcdefd'.
	self assert: (x replace: dict) equals: 'zbcwefw'.
	self assert: x equals: 'zbcwefw'.

]

{ #category : #tests }
FunctionalTest >> testSlide [
	self assert: (5 iota slide: 3) asArray equals: #((1 2 3) (2 3 4) (3 4 5)).
	self assert: (5 iota slide: 2) asArray equals: #((1 2) (2 3) (3 4) (4 5)).

]

{ #category : #tests }
FunctionalTest >> testUnique [
   self assert: (3 iota,5 iota) unique equals: #(1 2 3 4 5).
   self assert: (#(3 1),4 iota reversed,3 iota,5 iota) unique equals: #(3 1 4 2 5).

]
