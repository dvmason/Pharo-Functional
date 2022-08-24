"
I am a token that represents the :| deconstruct definition syntax
"
Class {
	#name : #ComposeColonBarToken,
	#superclass : #RBToken,
	#category : #'CompileWithCompose-Kernel'
}

{ #category : #testing }
ComposeColonBarToken >> isDestructure [

	^ true
]

{ #category : #testing }
ComposeColonBarToken >> isSpecial [
	^ true
]

{ #category : #accessing }
ComposeColonBarToken >> length [
	^ 2
]
