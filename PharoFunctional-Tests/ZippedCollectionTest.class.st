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
	zipped := #(1 2 3 1) zip: #(4 6 8 1).
	zipped2 := #(1 2 3 1) >==< #(4 6 8 1).

]

{ #category : #tests }
ZippedCollectionTest >> testBasic [
	self assert: (zipped at: 2) equals: (Pair with: 2 with: 6)
]

{ #category : #tests }
ZippedCollectionTest >> testCollect [
	self assert: (zipped collect: #+) equals: #(5 8 11 2).
	self assert: (zipped collect: #yourself) equals: zipped asArray.

]

{ #category : #tests }
ZippedCollectionTest >> testEquivalent [
	self assert: zipped equals: zipped2.

]

{ #category : #tests }
ZippedCollectionTest >> testSelect [
	self assert: (zipped select: #=) equals: {Pair with: 1 with: 1}.
	self assert: (zipped select: [: each | true]) equals: zipped asArray.

]
