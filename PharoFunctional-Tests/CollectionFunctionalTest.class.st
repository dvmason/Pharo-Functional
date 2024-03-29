Class {
	#name : #CollectionFunctionalTest,
	#superclass : #TestCase,
	#traits : 'ComposeSyntax',
	#classTraits : 'ComposeSyntax classTrait',
	#category : #'PharoFunctional-Tests-Tests'
}

{ #category : #tests }
CollectionFunctionalTest >> testFrequencies [
	self assert: (#(1 2 3 4 5) frequencies) equals: (Dictionary withAll: #(1 1 1 1 1)).
	self assert: (#(1 2 3 4 4) frequencies) equals: (Dictionary withAll: #(1 1 1 2)).
	self assert: (#(1 2 3)     frequencies) equals: (Dictionary withAll: #(1 1 1)).
]

{ #category : #tests }
CollectionFunctionalTest >> testGrouping [
	self assert: (#(1 2 3 4 4 1 1) groupByRunsTrue: [ :l :r | l = r]) equals: #((1) (2) (3) (4 4) (1 1)).
	self assert: (#(1 2 3 4 4 1 1) groupByRunsEqual: [ :v | v < 3]) equals: #((1 2) (3 4 4) (1 1)).
	self assert: (#(1 2 3 4 1 2 3 3 4 5 1 ) groupByRunsTrue: #<=) equals: #((1 2 3 4) (1 2 3 3 4 5) (1)).
	self assert: (#(1 2 3 4 4 2 3 1 1) groupByRunsEqual: [ :v | v bitAnd: 1]) equals: #((1) (2) (3) (4 4 2) (3 1 1)).

]

{ #category : #tests }
CollectionFunctionalTest >> testIsUnique [
	self assert: #(1 2 3 4 5) isUnique.
	self deny:   #(1 2 3 4 4) isUnique.
	self assert: #(1 2 3)     isUnique.
	self deny:   #(36 9 2 2)  isUnique.
]

{ #category : #tests }
CollectionFunctionalTest >> testScan [
	self assert: (#(1 2 3 4 5) scan: #+) equals: #(1 3 6 10 15).
	self assert: (#(1 2 3 4 5) scan: #*) equals: #(1 2 6 24 120).
	self assert: (#(1 2 3 4 5) scan: #-) equals: #(1 -1 -4 -8 -13).
	self assert: (#(36 9 2 2)  scan: #/) equals: #(36 4 2 1).
]

{ #category : #tests }
CollectionFunctionalTest >> testSlice [

	| slice |
	slice := (#( 1 2 3 4 5 6 7 8 ) collect: #yourself) sliceFrom: 2 to: 5.
	self assert: (slice collect: #negated) equals: #( -2 -3 -4 -5 ).
	self assert: slice size equals: 4.
	self should: [ slice at: 3 put: 42 ] raise: Error.
	slice mutable.
	slice at: 3 put: 42.
	self assert: slice reversed asArray equals: #( 5 42 3 2 ).
	slice reversed at: 3 put: 17.
	self assert: slice asArray equals: #( 2 17 42 5 ).
	self should: [ slice at: 0 put: 42 ] raise: Error.
	self should: [ slice at: 5 put: 42 ] raise: Error
]

{ #category : #tests }
CollectionFunctionalTest >> testSliceString [

	| slice |
	slice := ('abcdefgh' collect: #yourself) sliceFrom: 2 to: 5.
	self assert: (slice collect: #asUppercase) equals: 'BCDE'.
	self assert: slice size equals: 4.
	self should: [ slice at: 3 put: $Z ] raise: Error.
	slice mutable.
	slice at: 3 put: $Z.
	self assert: slice reversed asString equals: 'eZcb'.
	slice reversed at: 3 put: $X.
	self assert: slice asString equals: 'bXZe'.
	self should: [ slice at: 0 put: $. ] raise: Error.
	self should: [ slice at: 5 put: $. ] raise: Error.
	self assert: (slice sliceFrom: 2 to: 3) asString equals: 'XZ'.
	self assert: (slice sliceFrom: 2 to: 1) size equals: 0.
	self assert: (slice allButFirst) asString equals: 'XZe'.
	self assert: (slice allButLast) asString equals: 'bXZ'
]

{ #category : #tests }
CollectionFunctionalTest >> testValueValue [
	self assert: (#(1 2 3 4) with: #(2 4 6 8) collect: #+) equals: #(3 6 9 12).
	self assert: (#(1 2 3 4) with: #(2 4 6 8) collect: #bitOr:) equals: #(3 6 7 12).
	self assert: (#(1 2 3 4) with: #(2 4 6 8) collect: [: l : r | l+r]) equals: #(3 6 9 12).

]
