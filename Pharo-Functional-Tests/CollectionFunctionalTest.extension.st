Extension { #name : #CollectionFunctionalTest }

{ #category : #'*Pharo-Functional-Tests' }
CollectionFunctionalTest >> testScan [
	self assert: (#(1 2 3 4 5) scan: #+) equals: #(1 3 6 10 15).
	self assert: (#(1 2 3 4 5) scan: #*) equals: #(1 2 6 24 120).
	self assert: (#(1 2 3 4 5) scan: #-) equals: #(1 -1 -4 -8 -13).
	self assert: (#(36 9 2 2)  scan: #/) equals: #(36 4 2 1).
]
