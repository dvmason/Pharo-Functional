Class {
	#name : #ComposeScannerTest,
	#superclass : #RBScannerTest,
	#traits : 'ComposeSyntax',
	#classTraits : 'ComposeSyntax classTrait',
	#category : #'CompileWithCompose-Tests'
}

{ #category : #initialize }
ComposeScannerTest >> buildScannerForText: source [
	^ self scannerClass on: (ReadStream on: source)
]

{ #category : #initialize }
ComposeScannerTest >> scannerClass [
	^ ComposeScanner
]

{ #category : #tests }
ComposeScannerTest >> testNextDeconstructToken [

	| source scanner token |
	source := 'identifierToken:|'.
	scanner := self buildScannerForText: source.
	token := scanner next.
	self assert: token isIdentifier.
	self deny: token isError.
	token := scanner next.
	self assert: token isDestructure.
	self deny: token isError
]

{ #category : #tests }
ComposeScannerTest >> testNextPipeToken [
	| source scanner token |	
	source := 'identifierToken:>'.
	scanner := self buildScannerForText: source.
	token := scanner next.
	self assert: token isIdentifier.
	self deny: token isError.
	token := scanner next.
	self assert: token isPipe.
	self deny: token isError.

]
