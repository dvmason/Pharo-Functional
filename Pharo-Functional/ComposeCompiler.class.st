"
I subclass the OpalCompiler and add syntax recognition for a compose syntax: ':>'
"
Class {
	#name : #ComposeCompiler,
	#superclass : #OpalCompiler,
	#category : #'Pharo-Functional-Compose'
}

{ #category : #accessing }
ComposeCompiler >> compilationContext [
	^ compilationContext ifNil: [ compilationContext := self compilationContextClass default parserClass: RBParser]
]

{ #category : #'public access' }
ComposeCompiler >> compile [
	self halt.
	^ super compile
]
