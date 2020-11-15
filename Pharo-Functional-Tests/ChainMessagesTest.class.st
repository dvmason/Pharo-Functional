Class {
	#name : #ChainMessagesTest,
	#superclass : #TestCase,
	#category : #'Pharo-Functional-Tests-Tests'
}

{ #category : #tests }
ChainMessagesTest >> testChain [
	self assert: (
	 17 chain negated
		; min: -53
		; abs
		; < 100
		; and: [ 4 > 2 ]
		; and: [ 5 < 10 ]
		; ifTrue: [ 42 ] ifFalse: [ 99 ]) equals: 42
]

{ #category : #tests }
ChainMessagesTest >> testSimple [
	self assert: (#('apple' 'peach' 'banana') chain
	  groupedBy: #size;
	  select: [ :each | each size even ];
	  values;
		flatCollect: #asCommaString as: String) equals: 'apple, peach'
]
