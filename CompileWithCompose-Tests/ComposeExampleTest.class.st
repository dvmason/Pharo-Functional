Class {
	#name : #ComposeExampleTest,
	#superclass : #RBScannerTest,
	#traits : 'ComposeSyntax',
	#classTraits : 'ComposeSyntax classTrait',
	#category : #'CompileWithCompose-Tests'
}

{ #category : #tests }
ComposeExampleTest >> testCompose [
	self assert: (
	 17 negated
		:> min: -53
		:> abs
		:> < 100
		:> and: [ 4 > 2 ]
		:> and: [ 5 < 10 ]
		:> ifTrue: [ 42 ] ifFalse: [ 99 ]) equals: 42
]

{ #category : #tests }
ComposeExampleTest >> testSimple [
	self assert: (#('apple' 'peach' 'banana')
	  groupedBy: #size :>
	  select: [ :each | each size even ] :>
	  values :>
		flatCollect: #asCommaString as: String) equals: 'apple, peach'
]
