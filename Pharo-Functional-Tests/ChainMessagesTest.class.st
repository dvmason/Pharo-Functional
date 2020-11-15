Class {
	#name : #ChainMessagesTest,
	#superclass : #TestCase,
	#category : #'Pharo-Functional-Tests-Tests'
}

{ #category : #tests }
ChainMessagesTest >> testSimple [
	self assert: (#('apple' 'peach' 'banana') chain
	  groupedBy: #size;
	  select: [ :each | each size even ];
	  values;
		flatCollect: #asCommaString as: String) equals: 'apple, peach'
]
