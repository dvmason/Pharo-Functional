Class {
	#name : #FunctionalTest,
	#superclass : #TestCase,
	#traits : 'ComposeSyntax',
	#classTraits : 'ComposeSyntax classTrait',
	#category : #'PharoFunctional-Tests-Tests'
}

{ #category : #tests }
FunctionalTest >> testAdjacentFind [
	self assert: (#(1 2 3 3 1 1 4) adjacentFind: #=) first equals: 3.
	self assert: ('abccaad' adjacentFind: #=) first equals: $c.
	self assert: ((#(1 2 3) adjacentFind: #=) nilOr: #first) equals: nil.

]

{ #category : #tests }
FunctionalTest >> testCombinations [
	self assert: (3 iota combinationsOf: 2) asSet equals: #((1 2) (1 3) (2 3)) asSet.
	self assert: ('abc' combinationsOf: 2) asSet equals: #('ab' 'ac' 'bc') asSet. " depends on SequencableCollection>>#combinations:atATimeDo: using `self species` "
	self assert: (3 iota combinationsOf: 2 select: [: each | each sum = 4]) equals: #((1 3)).
	self assert: ('abcde' combinationsOf: 2 select: [: each | each allSatisfy: #isVowel]) equals: #('ae').
	self assert: ('abcde' combinationsOf: 2 select: #allSatisfy: @@ #isVowel) equals: #('ae').
	self assert: (3 iota combinationsOf: 2 select: [: each | each sum = 4] collect: [: each | each first]) equals: #(1).
	self assert: (3 iota combinationsOf: 2 collect: [: each | each sum]) asSet equals: #(3 4 5) asSet.

]

{ #category : #tests }
FunctionalTest >> testCombinatorAtop [ 
	"The Blackbird"

   "Example #1: Test if two sequences are mutually exclusive"
   "Not using combinators"
   self deny: (#(1 2 3) intersection: #(2 3 4)) isEmpty.
   self assert: (#(1 2 3) intersection: #(4 5 6)) isEmpty.
	"Using combinators"
   self deny: #(1 2 3) (#isEmpty <|> #intersection:): #(2 3 4).
   self assert: #(1 2 3) (#isEmpty <|> #intersection:): #(4 5 6)

]

{ #category : #tests }
FunctionalTest >> testCombinatorOver [
	"The Psi Bird"

   "Example #1: Test the difference in length of string"
   "Not using combinators"
   self assert: (('mouse' size) - ('cat' size)) equals: 2.
	"Using combinators"
   self assert: ('mouse' (#- <|> #size): 'cat') equals: 2.

	"Example #2: Test if strings are anagrams"
	"Not using combinators"
	self deny: ('horse' sorted = 'cat' sorted).
   self assert: ('horse' sorted = 'shore' sorted).
	"Using combinators"
   self deny: 'horse' (#= <|> #sorted): 'cat'.
   self assert: 'horse' (#= <|> #sorted): 'shore'


]

{ #category : #tests }
FunctionalTest >> testCombinatorOverWithGroupByRuns2Arg [
   "These algorithms are important:
    groupByRuns      -> chunk_by_key       C++26
    groupByRunsTrue: -> chunk_by (groupBy) C++23
    groupsOf:        -> chunk              C++23"

	| aplExpr isDigitOrSpace expected |

   "groupByRuns2Arg: doesn't work with strings ATM
    isDigitOrSpace := [ :c | (c isDigit) or: [ c == $ ] ].
    aplExpr        := 'max fold 1 + 1 2 3 4 5'" 

   aplExpr        := #(2 1 3 1 3 1 4 1 3 4 3 1).
   isDigitOrSpace := [ :x | (x == 1) or: [ x == 3 ] ].
   expected       := #((2) (1 3 1 3 1) (4) (1 3) (4) (3 1)).

	self assert: (aplExpr groupByRunsTrue: [ :a :b | ((a == 1) or: [ a == 3 ]) and: [ (b == 1) or: [ b == 3 ] ]]) equals: expected.
	self assert: (aplExpr groupByRunsTrue: [ :a :b | ( isDigitOrSpace value: a ) and: [ isDigitOrSpace value: b ] ]) equals: expected.
	self assert: (aplExpr groupByRunsTrue: [ :a :b | a (isDigitOrSpace) and: [ b (isDigitOrSpace) ] ]) equals: expected.
   self assert: (aplExpr groupByRunsTrue: [ :a : b| a (#and: <|> isDigitOrSpace): b ]) equals: expected.
   self assert: (aplExpr groupByRunsTrue:  (#and: <|> isDigitOrSpace)) equals: expected.

]

{ #category : #tests }
FunctionalTest >> testCurry [
	self assert: (5 @@ #- value: 4) equals: 1.
	self assert: 4 (5 @@ #-) equals: 1.
	self assert: (#- @@ 4 value: 9) equals: 5.
	self assert: 9 (#- @@ 4) equals: 5.
	self assert: 4 (5 curry: #-) equals: 1.
	self assert: 9 (#- curry: 4) equals: 5.
	self assert: ((5 curry: #-) value: 4) equals: 1.
	self assert: ((#- curry: 4) value: 9) equals: 5.
	self assert: ((5 curry: [:l :r | l-r]) value: 4) equals: 1.
	self assert: (([:l :r | l-r] curry: 4) value: 9) equals: 5.

]

{ #category : #tests }
FunctionalTest >> testCurry2 [

	| addArrays |
	addArrays := #+ curry: #map:map:.
	self
		assert: (addArrays value: #( 1 2 3 ) value: #( -1 0 1 ))
		equals: #( 0 2 4 ) 
]

{ #category : #tests }
FunctionalTest >> testCurry3 [

	self
		assert: (([:x :y| x+y ] curry value: 4) value: 3)
		equals: 7
]

{ #category : #tests }
FunctionalTest >> testCycle [
   self assert: (#(1 2 3 4) cycle: 2)  equals: #(1 2).
   self assert: (#(1 2 3 4) cycle: 3)  equals: #(1 2 3).
   self assert: (#(1 2 3 4) cycle: 6)  equals: #(1 2 3 4 1 2).
   self assert: (#(1 2 3 4) cycle: 10) equals: #(1 2 3 4 1 2 3 4 1 2).
   self assert: ('abcd' cycle: 6)  equals: 'abcdab'.
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
	x := 'abc' , 'defd'.
	dict := {:Dictionary $a -> $z. $d -> $w }.
	self assert: (x copyReplace: dict) equals: 'zbcwefw'.
	self assert: x equals: 'abcdefd'.
	self assert: (x replace: dict) equals: 'zbcwefw'.
	self assert: x equals: 'zbcwefw'
]

{ #category : #tests }
FunctionalTest >> testSlide [
	self assert: (5 iota slide: 3) asArray equals: #((1 2 3) (2 3 4) (3 4 5)).
	self assert: (5 iota slide: 2) asArray equals: #((1 2) (2 3) (3 4) (4 5)).
	self assert: ('abcde' slide: 2) asArray equals: #('ab' 'bc' 'cd' 'de').

]

{ #category : #tests }
FunctionalTest >> testUnique [
   self assert: (3 iota,5 iota) unique equals: #(1 2 3 4 5).
   self assert: (#(3 1),4 iota reversed,3 iota,5 iota) unique equals: #(3 1 4 2 5).
   self assert: 'cadcbaabcabcde' unique equals: 'cadbe'.

]
