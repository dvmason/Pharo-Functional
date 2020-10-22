Extension { #name : #CollectionFunctionalTest }

{ #category : #'*Pharo-Functional-Tests' }
CollectionFunctionalTest >> testScan [
	self assert: (#(1 2 3 4 5) scan: #+) equals: #(1 3 6 10 15).

]
