Extension { #name : #CollectionRootTest }

{ #category : #'*Pharo-Functional-Tests' }
CollectionRootTest >> testScan [
	self assert: (#(1 2 3 4 5) scan: #+) equals: #(1 3 6 10 15).

]
