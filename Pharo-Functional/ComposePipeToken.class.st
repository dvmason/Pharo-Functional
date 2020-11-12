Class {
	#name : #ComposePipeToken,
	#superclass : #RBToken,
	#category : #'Pharo-Functional-Compose'
}

{ #category : #testing }
ComposePipeToken >> isPipe [
	^ true
]

{ #category : #accessing }
ComposePipeToken >> length [
	^ 2
]
