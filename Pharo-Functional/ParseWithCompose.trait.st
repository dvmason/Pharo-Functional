"
I add a reference to an alternate parser that includes the compose operator: ':>' so that all methods in a using class can use that syntax extension.
"
Trait {
	#name : #ParseWithCompose,
	#category : #'Pharo-Functional-Compose'
}

{ #category : #compiler }
ParseWithCompose classSide >> compilerClass [
	"Answer a compiler class appropriate for source methods of a class that uses this trait."

	^ ComposeCompiler
]
