"
I contain tests for ZippedCollection
"
Class {
	#name : #ZippedCollectionTest,
	#superclass : #TestCase,
	#instVars : [
		'zipped',
		'zipped2'
	],
	#category : #'PharoFunctional-Tests-Tests'
}

{ #category : #running }
ZippedCollectionTest >> setUp [
	super setUp.
	zipped := #(1 2 3) zip: #(4 6 8).
	zipped2 := #(1 2 3) >==< #(4 6 8).

]

{ #category : #tests }
ZippedCollectionTest >> testBasic [
	self assert: (zipped at: 2) equals: (Pair with: 2 with: #b)
]

{ #category : #tests }
ZippedCollectionTest >> testCollect [
	self assert: (zipped collect: #+) equals: #(5 8 11).
	self assert: (zipped collect: #yourself) equals: zipped asArray.

]

{ #category : #tests }
ZippedCollectionTest >> testEquivalent [
	self assert: zipped equals: zipped2.

]
