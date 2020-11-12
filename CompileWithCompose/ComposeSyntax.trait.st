"
I add a reference to an alternate parser that includes the compose operator: ':>' so that all methods in a using class can use that syntax extension.
"
Trait {
	#name : #ComposeSyntax,
	#category : #'CompileWithCompose-Kernel'
}

{ #category : #compiler }
ComposeSyntax classSide >> compilerClass [
	"Answer a compiler class appropriate for source methods of a class that uses this trait."

	^ ComposeCompiler
]
