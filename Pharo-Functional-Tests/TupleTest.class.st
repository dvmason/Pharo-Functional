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
	pair replaceFrom: 1 to: 2 with: #(4 5 6) startingAt: 2.
	self assert: pair first equals: 5.
	self assert: pair last equals: 6.

]

{ #category : #tests }
TupleTest >> testTupleBasics [
	| tuple temp |
	tuple := Tuple with: 2 with: 5.
	self assert: tuple class equals: Pair.
	tuple := Tuple with: 2.
	self assert: tuple class equals: Tuple.
	self assert: tuple first equals: 2.
	self should: [ tuple second ] raise: SubscriptOutOfBounds.
	tuple := Tuple with: 2 with: 3 with: 4.
	self assert: tuple class equals: Tuple.
	self assert: tuple first equals: 2.
	self assert: tuple second equals: 3.
	self assert: tuple last equals: 4.
	temp := {1. 2. 3}.
	tuple := Tuple withAll: temp.
	temp at: 1 put: 42.
	self deny: tuple first equals: temp first.
	self assert: tuple last equals: temp last.
	tuple replaceFrom: 2 to: 3 with: #(4 5 6) startingAt: 2.
	self assert: tuple second equals: 5.
	self assert: tuple last equals: 6.

]
