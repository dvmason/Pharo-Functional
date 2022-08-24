"
I am a token that represents the :> compose or pipe syntax
"
Class {
	#name : #ComposePipeToken,
	#superclass : #RBToken,
	#category : #'CompileWithCompose-Kernel'
}

{ #category : #testing }
ComposePipeToken >> isPipe [
	^ true
]

{ #category : #testing }
ComposePipeToken >> isSpecial [
	^ true
]

{ #category : #accessing }
ComposePipeToken >> length [
	^ 2
]
