Class {
	#name : #FunctionalTest,
	#superclass : #TestCase,
	#category : #'Pharo-Functional-Tests-Tests'
}

{ #category : #tests }
FunctionalTest >> testCurry [
	self assert: ((5 curry: #-) value: 4) equals: 1.
	self assert: ((#- curry: 4) value: 9) equals: 5.
	self assert: ((5 curry: [:l :r | l-r]) value: 4) equals: 1.
	self assert: (([:l :r | l-r] curry: 4) value: 9) equals: 5.

]
