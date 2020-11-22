Class {
	#name : #CollectionFunctionalTest,
	#superclass : #TestCase,
	#category : #'PharoFunctional-Tests-Tests'
}

{ #category : #tests }
CollectionFunctionalTest >> testFrequencies [
	self assert: (#(1 2 3 4 5) frequencies) equals: (Dictionary withAll: #(1 1 1 1 1)).
	self assert: (#(1 2 3 4 4) frequencies) equals: (Dictionary withAll: #(1 1 1 2)).
	self assert: (#(1 2 3)     frequencies) equals: (Dictionary withAll: #(1 1 1)).
]

{ #category : #tests }
CollectionFunctionalTest >> testGrouping [
	self assert: 	(#(1 2 3 4 4 1 1) groupByRuns2Arg: [ :l :r | l = r]) equals: #((1) (2) (3) (4 4) (1 1)).
	self assert: (#(1 2 3 4 1 2 3 3 4 5 1 ) groupByRuns2Arg: #<=) equals: #((1 2 3 4) (1 2 3 3 4 5) (1)).
]

{ #category : #tests }
CollectionFunctionalTest >> testIsUnique [
	self assert: (#(1 2 3 4 5) isUnique) equals: true.
	self assert: (#(1 2 3 4 4) isUnique) equals: false.
	self assert: (#(1 2 3)     isUnique) equals: true.
	self assert: (#(36 9 2 2)  isUnique) equals: false.
]

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
