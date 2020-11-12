Class {
	#name : #ComposeScannerTest,
	#superclass : #RBScannerTest,
	#category : #'CompileWithCompose-Tests'
}

{ #category : #initialize }
ComposeScannerTest >> scannerClass [
	^ ComposeScanner
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
