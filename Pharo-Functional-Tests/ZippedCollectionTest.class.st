"
I contain tests for ZippedCollection
"
Class {
	#name : #ZippedCollectionTest,
	#superclass : #TestCase,
	#instVars : [
		'zipped'
	],
	#category : #'Pharo-Functional-Tests'
}

{ #category : #running }
ZippedCollectionTest >> setUp [
	super setUp.
	zipped := #(1 2 3) zip: #(a b c).

]

{ #category : #tests }
ZippedCollectionTest >> testBasic [
	self assert: (zipped at: 2) equals: (Pair with: 2 with: #b)
]
