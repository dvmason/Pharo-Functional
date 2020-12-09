"
I am a class that hold interim values of an object so that it can receive a sequence of cascade messages and perform them sequentially on the values. This is like a chain or pipe operator. It's not super performant because it does a DNU and perform on each cascade message. Better, if you're on Pharo is to use the :> syntax from the CompileWithCompose package.
"
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
