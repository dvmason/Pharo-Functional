Extension { #name : #UndefinedObject }

{ #category : #'*CompileWithCompose' }
UndefinedObject class >> compilerClass [
	"Answer a compiler class appropriate for source methods of a class that uses this trait."
	<pharoJsSkip>
	^ ComposeCompiler
]
