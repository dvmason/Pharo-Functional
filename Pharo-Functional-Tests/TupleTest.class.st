"
Tests for the Pair class
"
Class {
	#name : #TupleTest,
	#superclass : #TestCase,
	#category : #'Pharo-Functional-Tests'
}

{ #category : #tests }
TupleTest >> testPairBasics [
	| pair |
	pair := Pair with: 2 with: 5.
	self assert: pair first equals: 2.
	self assert: pair last equals: 5.
	self assert: pair second equals: 5.
	self should: [ pair third ] raise: SubscriptOutOfBounds.


]

{ #category : #tests }
TupleTest >> testTupleBasics [
	| tuple |
	tuple := Tuple with: 2 with: 5.
	self assert: tuple class equals: Pair.
	tuple := Tuple with: 2.
	self assert: tuple class equals: Tuple.
	self assert: tuple first equals: 2.
	self assert: tuple last equals: 2.
	self should: [ tuple second ] raise: SubscriptOutOfBounds.


]
