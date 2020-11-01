Class {
	#name : #CollectionFunctionalTest,
	#superclass : #TestCase,
	#category : #'Pharo-Functional-Tests'
}

{ #category : #tests }
CollectionFunctionalTest >> testScan [
	self assert: (#(1 2 3 4 5) scan: #+) equals: #(1 3 6 10 15).
	self assert: (#(1 2 3 4 5) scan: #*) equals: #(1 2 6 24 120).
	self assert: (#(1 2 3 4 5) scan: #-) equals: #(1 -1 -4 -8 -13).
	self assert: (#(36 9 2 2)  scan: #/) equals: #(36 4 2 1).
]

{ #category : #tests }
CollectionFunctionalTest >> testValueValue [
	self assert: (#(1 2 3 4) with: #(2 4 6 8) collect: #+) equals: #(3 6 9 12).
	self assert: (#(1 2 3 4) with: #(2 4 6 8) collect: #bitOr:) equals: #(3 6 7 12).
	self assert: (#(1 2 3 4) with: #(2 4 6 8) collect: [: l : r | l+r]) equals: #(3 6 9 12).

]
