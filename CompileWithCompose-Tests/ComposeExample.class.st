"
I am a simple class used in ComposeExampleTest
"
Class {
	#name : #ComposeExample,
	#superclass : #Object,
	#traits : 'ComposeSyntax',
	#classTraits : 'ComposeSyntax classTrait',
	#instVars : [
		'first',
		'second'
	],
	#category : #'CompileWithCompose-Tests'
}

{ #category : #operating }
ComposeExample >> + anInteger [ 
	^ first + anInteger
]

{ #category : #operating }
ComposeExample >> > anInteger [ 
	^ first > anInteger
]

{ #category : #accessing }
ComposeExample >> asOrderedCollection [
	^ { first . second }
]

{ #category : #accessing }
ComposeExample >> first: value [
	^ first := value
]

{ #category : #accessing }
ComposeExample >> second: value [
	^ second := value
]
