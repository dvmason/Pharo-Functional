Class {
	#name : #ComposeParser,
	#superclass : #RBParser,
	#category : #'Pharo-Functional-Compose'
}

{ #category : #accessing }
ComposeParser >> scannerClass [
	^ ComposeScanner
]
