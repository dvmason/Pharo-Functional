"
I subclass the OpalCompiler and add syntax recognition for a compose syntax: ':>'
"
Class {
	#name : #ComposeCompiler,
	#superclass : #OpalCompiler,
	#category : #'CompileWithCompose-Kernel'
}

{ #category : #accessing }
ComposeCompiler >> compilationContext [
	^ compilationContext ifNil: [ compilationContext := self compilationContextClass default parserClass: ComposeParser ]
]
