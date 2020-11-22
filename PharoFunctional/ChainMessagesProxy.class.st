Class {
	#name : #ChainMessagesProxy,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'PharoFunctional-Kernel'
}

{ #category : #'reflective operations' }
ChainMessagesProxy >> doesNotUnderstand: aMessage [
	^ target := aMessage sendTo: target
]

{ #category : #initialization }
ChainMessagesProxy >> initializeTargetValue: anObject [
	target := anObject.

]
