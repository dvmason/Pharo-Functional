"
I subclass the RBParser and add syntax recognition for a compose syntax: ':>'
"
Class {
	#name : #ComposeParser,
	#superclass : #RBParser,
	#category : #'Pharo-Functional-Compose'
}

{ #category : #accessing }
ComposeParser >> scannerClass [
	^ ComposeScanner
]
